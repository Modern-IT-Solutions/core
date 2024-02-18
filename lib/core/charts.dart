import 'dart:math';

import 'package:core/core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:core/features/users/presentation/dailogs.dart';
import 'package:lib/lib.dart';
import 'package:timeago/timeago.dart' as timeago;

/// [SimpleModelViewChart]
class SimpleModelViewChart<T extends Model> extends StatefulWidget {
  final ModelListViewController<T> controller;
  const SimpleModelViewChart({super.key, required this.controller});

  @override
  State<SimpleModelViewChart> createState() => _SimpleModelViewChartState<T>();
}

class _SimpleModelViewChartState<T extends Model> extends State<SimpleModelViewChart<T>> {
  List<Offset> points = [];
  ModelListViewController<T> get controller => widget.controller;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    // controller.load();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.load();
    });
  }

  updatePoints() {
    if (mounted && controller.value != null && controller.filtered != null) {
      var min = controller.filtered!.isEmpty ? DateTime.now().millisecondsSinceEpoch : controller.filtered!.reduce((a, b) => a.updatedAt.isBefore(b.updatedAt) == true ? a : b).updatedAt.millisecondsSinceEpoch;
      var max = controller.filtered!.isEmpty ? DateTime.now().millisecondsSinceEpoch : controller.filtered!.reduce((a, b) => a.updatedAt.isAfter(b.updatedAt) == true ? a : b).updatedAt.millisecondsSinceEpoch;

      var period = (max - min) / 50;
      var points = <Offset>[];
      for (var i = 0; i < 50; i++) {
        var start = min + period * i;
        var end = min + period * (i + 1);
        var count = controller.filtered!.where((e) {
          var time = e.updatedAt.millisecondsSinceEpoch;
          return time >= start && time < end;
        }).length;
        points.add(Offset(start.toDouble(), count.toDouble()));
      }
      this.points = points;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        updatePoints();
        return LoadingBox(
          loading: controller.value?.loading ?? true,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ModelViewFiltersChips(
                  controller: controller,
                  searchEnabled: false,
                ),
              ),
              if (points.length > 3)
                SimpleModelViewChartLine(
                  points: points,
                )
              else
                const AspectRatio(
                  aspectRatio: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.error_circle_24_regular, size: 30),
                      SizedBox(height: 12),
                      Text("No data"),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

////////////////////////////// PieChartSample3 ////////////////////
class SimpleModelViewChartLine extends StatefulWidget {
  final List<Offset> points;
  const SimpleModelViewChartLine({super.key, required this.points});

  @override
  State<SimpleModelViewChartLine> createState() => _SimpleModelViewChartLineState();
}

class _SimpleModelViewChartLineState extends State<SimpleModelViewChartLine> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  int _prevDay = 0;
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;

    // same day shows only once
    int currentDay = DateTime.fromMillisecondsSinceEpoch(value.toInt()).day;
    if (currentDay != _prevDay) {
      text = Text(
        currentDay.toString(),
        style: style,
        textAlign: TextAlign.center,
      );
      _prevDay = currentDay;
    } else {
      text = Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    Widget text;
    if (value.toInt() % 5 == 0) {
      text = Text(
        value.toInt().toString(),
        style: style,
        textAlign: TextAlign.right,
      );
    } else {
      text = Container();
    }

    return text;
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).colorScheme.primary,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              return LineTooltipItem(
                "${timeago.format(DateTime.fromMillisecondsSinceEpoch(barSpot.x.toInt()))} : ${barSpot.y.toInt()}",
                Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 1,
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 2,
                    strokeColor: Theme.of(context).colorScheme.surface,
                  );
                },
              ),
            );
          }).toList();
        },
      ),
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: bottomTitleWidgets,
        )),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var item in widget.points!)
              FlSpot(
                item.dx,
                item.dy,
              ),
          ],
          isCurved: false,
          color: Theme.of(context).colorScheme.primary,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                Theme.of(context).colorScheme.primary.withOpacity(0),
              ],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          aboveBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                Theme.of(context).colorScheme.onPrimary.withOpacity(0),
              ],
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
