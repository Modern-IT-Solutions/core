import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
  }) : this.custom = null;

  const DataFlagWidget.error({
    super.key,
    this.flag = DataFalg.error,
    this.color = Colors.grey,
  }) : this.custom = null;

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
            this.custom?.nullIfEmpty == null ? flag.name : this.custom!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
