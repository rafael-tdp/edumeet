import 'package:client/core/models/stat.dart';
import 'package:client/core/services/stats_services.dart';
import 'package:client/utils/colors.dart';
import 'package:client/widgets/donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
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
  Stat _stats = Stat(
    userByMonth: [],
    eventByMonth: [],
    topSubjects: [],
    averageParticipantsByEvent: AverageParticipants(previousYear: 0, currentYear: 0),
  );

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    try {
      final stats = await StatsServices.getStats();
      setState(() {
        _stats = stats;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<TopSubject> topSubjects = _stats.topSubjects;
    final List<int> userByMonth = _stats.userByMonth;
    final List<int> eventByMonth = _stats.eventByMonth;
    final AverageParticipants averageParticipants = _stats.averageParticipantsByEvent;


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
              LineChartWidget(monthlyEvents: eventByMonth, chartTitle: "Événements par mois",isCurved: false),
              SizedBox(height: 16),
              _buildStatCard("Participants moyens par événement", averageParticipants.previousYear as double, averageParticipants.currentYear as double),
              SizedBox(height: 16),
              LineChartWidget(monthlyEvents: userByMonth, chartTitle: "Utilisateurs par mois", lineColor: AppColors.blue, isCurved: false),
              SizedBox(height: 16),
              SubjectsChart(topSubjects: topSubjects, chartTitle: "Top 5 des matières les plus populaires"),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, double previousYearValue, double currentYearValue) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Précédente année', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(previousYearValue.toStringAsFixed(1), style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Année en cours', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(currentYearValue.toStringAsFixed(1), style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}