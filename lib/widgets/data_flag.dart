import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

enum DataFalg {
  none,
  empty,
  nul,
  error,
  custom,
}

/// [DataFlagWidget] is just widget to show empty value
/// it shows [Text] with [DataFlagWidget.text] or [DataFlagWidget.icon] or both
class DataFlagWidget extends StatelessWidget {
  /// [DataFlagWidget.flag] is the flag to show
  final DataFalg flag;
  final String? custom;
  final Color color;

  const DataFlagWidget({
    super.key,
    this.flag = DataFalg.custom,
    this.color = Colors.grey,
    this.custom,
  });

  const DataFlagWidget.empty({
    super.key,
    this.flag = DataFalg.empty,
    this.color = Colors.grey,
  }) : custom = null;

  const DataFlagWidget.error({
    super.key,
    this.flag = DataFalg.error,
    this.color = Colors.red,
  }) : custom = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(4),
            color: color,
          ),
          child: Text(
            (custom?.nullIfEmpty == null ? flag.name : custom!).toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
