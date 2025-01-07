import 'package:client/core/models/stat.dart';
import 'package:client/core/services/stats_services.dart';
import 'package:client/utils/colors.dart';
import 'package:client/widgets/donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:client/widgets/line_chart.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({super.key});
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int touchedIndex = -1;
  Stat _stats = Stat(
    userByMonth: [],
    eventByMonth: [],
    topSubjects: [],
    averageParticipantsByEvent:
        AverageParticipants(previousYear: 0, currentYear: 0),
  );

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
      });
    } catch (error) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<TopSubject> topSubjects = _stats.topSubjects;
    final List<int> userByMonth = _stats.userByMonth;
    final List<int> eventByMonth = _stats.eventByMonth;
    final AverageParticipants averageParticipants =
        _stats.averageParticipantsByEvent;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LineChartWidget(
                monthlyEvents: eventByMonth,
                chartTitle: "Événements par mois",
                isCurved: false,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                  "Participants moyens par événement",
                  averageParticipants.previousYear,
                  averageParticipants.currentYear),
              const SizedBox(height: 16),
              LineChartWidget(
                  monthlyEvents: userByMonth,
                  chartTitle: "Utilisateurs par mois",
                  isCurved: false),
              const SizedBox(height: 16),
              SubjectsChart(
                  topSubjects: topSubjects,
                  chartTitle: "Top 5 des matières les plus populaires"),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, double previousYearValue, double currentYearValue) {
    return Card(
      color: AppColors.lightPurple,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Année précédente',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(previousYearValue.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Année en cours',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(currentYearValue.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
