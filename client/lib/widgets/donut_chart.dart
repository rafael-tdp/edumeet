import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SubjectsChart extends StatefulWidget {
  final List<Map<String, dynamic>> topSubjects;
  final String chartTitle;
  final double chartDiameterFactor;
  final bool showTitle;
  final double centerSpaceRadiusFactor;

  SubjectsChart({
    required this.topSubjects,
    required this.chartTitle,
    this.chartDiameterFactor = 0.6,
    this.showTitle = true,
    this.centerSpaceRadiusFactor = 0.3,
  });

  @override
  DonutChart createState() => DonutChart();
}

class DonutChart extends State<SubjectsChart> {
  int touchedIndex = -1;

  Color _getSubjectColor(int subject) {
    switch (subject) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.chartTitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.chartTitle,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Année Précédente",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double chartDiameter =
                              constraints.maxWidth * widget.chartDiameterFactor;
                          double chartRadius = chartDiameter / 2;

                          return Container(
                            width: chartDiameter,
                            height: chartDiameter,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,
                                centerSpaceRadius: chartRadius * widget.centerSpaceRadiusFactor,
                                sections: widget.topSubjects.map((subject) {
                                  final double previousYearEvents = subject["previousYear"].toDouble();
                                  final isTouched = widget.topSubjects.indexOf(subject) == touchedIndex;
                                  final fontSize = isTouched ? 25.0 : 16.0;
                                  final radius = isTouched ? chartRadius * 0.6 : chartRadius * 0.5;
                                  return PieChartSectionData(
                                    value: previousYearEvents,
                                    color: _getSubjectColor(widget.topSubjects.indexOf(subject)),
                                    title: isTouched
                                        ? '${subject["previousYear"]} événements'
                                        : subject["subject"],
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Année Courante",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double chartDiameter =
                              constraints.maxWidth * widget.chartDiameterFactor;
                          double chartRadius = chartDiameter / 2;

                          return Container(
                            width: chartDiameter,
                            height: chartDiameter,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,
                                centerSpaceRadius: chartRadius * widget.centerSpaceRadiusFactor,
                                sections: widget.topSubjects.map((subject) {
                                  final double currentYearEvents = subject["events"].toDouble();
                                  final isTouched = widget.topSubjects.indexOf(subject) == touchedIndex;
                                  final fontSize = isTouched ? 25.0 : 16.0;
                                  final radius = isTouched ? chartRadius * 0.6 : chartRadius * 0.5;
                                  return PieChartSectionData(
                                    value: currentYearEvents,
                                    color: _getSubjectColor(widget.topSubjects.indexOf(subject)),
                                    title: isTouched
                                        ? '${subject["events"]} événements'
                                        : subject["subject"],
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}