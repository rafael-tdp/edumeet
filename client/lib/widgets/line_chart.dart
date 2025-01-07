import 'package:client/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<int> monthlyEvents;
  final String chartTitle;
  final double? maxY;
  final double horizontalInterval;
  final double verticalInterval;
  final bool showGrid;
  final bool showDots;
  final bool isCurved;
  final Color lineColor;
  final double barWidth;
  final double reservedSize;
  final bool showTitle;
  final List<String>? months;

  const LineChartWidget({
    super.key,
    required this.monthlyEvents,
    this.chartTitle = "",
    this.maxY,
    this.horizontalInterval = 10,
    this.verticalInterval = 10,
    this.showGrid = true,
    this.showDots = true,
    this.isCurved = true,
    this.lineColor = AppColors.purple,
    this.barWidth = 4.0,
    this.reservedSize = 30,
    this.showTitle = true,
    this.months,
  });

  @override
  Widget build(BuildContext context) {
    double computedMaxY = maxY ??
        (monthlyEvents.isNotEmpty
            ? (monthlyEvents.reduce((a, b) => a > b ? a : b) / verticalInterval)
                    .ceil() *
                verticalInterval
            : 100.0);

    computedMaxY = computedMaxY + (computedMaxY * 0.1);

    computedMaxY = computedMaxY < 10 ? 10 : computedMaxY;

    List<FlSpot> eventSpots = List.generate(monthlyEvents.length, (index) {
      return FlSpot(index.toDouble(), monthlyEvents[index].toDouble());
    });

    List<String> defaultMonths = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    List<String> monthsList = months ?? defaultMonths;

    double dynamicVerticalInterval = verticalInterval;
    if (computedMaxY > 100) {
      dynamicVerticalInterval = (computedMaxY / 10).roundToDouble();
    }

    return Card(
      color: AppColors.lightPurple,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (chartTitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  chartTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            Container(
              color: Colors.transparent,
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: showGrid,
                    verticalInterval: dynamicVerticalInterval,
                    horizontalInterval: horizontalInterval,
                  ),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1)),
                  lineBarsData: [
                    LineChartBarData(
                      spots: eventSpots,
                      isCurved: isCurved,
                      color: lineColor,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: showDots),
                      barWidth: barWidth,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: showTitle,
                        interval: dynamicVerticalInterval,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: showTitle,
                        reservedSize: reservedSize,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            monthsList[value.toInt() % monthsList.length],
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  minY: 0,
                  maxY: computedMaxY,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
