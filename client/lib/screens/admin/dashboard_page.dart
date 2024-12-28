import 'package:client/utils/colors.dart';
import 'package:client/widgets/donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:client/widgets/line_chart.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final int totalUsers = 500;
    final int totalEvents = 1000;

    final double averageParticipants = (totalEvents > 0) ? (totalUsers / totalEvents) : 0;

    final List<Map<String, dynamic>> topSubjects = [
      {"subject": "Mathématiques", "events": 120, "previousYear": 100},
      {"subject": "Histoire", "events": 95, "previousYear": 85},
      {"subject": "Physique", "events": 85, "previousYear": 80},
      {"subject": "Anglais", "events": 75, "previousYear": 70},
      {"subject": "Chimie", "events": 60, "previousYear": 50},
    ];

    final List<int> monthlyEvents = [
      10, 5, 0, 0, 0, 1, 50, 6, 9, 0, 0, 100
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LineChartWidget(monthlyEvents: monthlyEvents, chartTitle: "Événements par mois"),
              SizedBox(height: 16),
              _buildStatCard("Participants moyens par événement", "${averageParticipants.toStringAsFixed(2)} participants"),
              SizedBox(height: 16),
              LineChartWidget(monthlyEvents: monthlyEvents, chartTitle: "Utilisateurs par mois", lineColor: AppColors.blue),
              SizedBox(height: 16),
              SubjectsChart(topSubjects: topSubjects, chartTitle: "Top 5 des matières les plus populaires"),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}