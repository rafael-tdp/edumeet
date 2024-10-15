import 'package:flutter/material.dart';
import '../Utils/colors.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Map<String, String>> _courses = [
    {
      "title": "Cours de JavaScript",
      "time": "Lundi, 10:00 - 12:00",
    },
    {
      "title": "Cours de Flutter",
      "time": "Mercredi, 14:00 - 16:00",
    },
    {
      "title": "Cours de Sécurité Web",
      "time": "Vendredi, 09:00 - 11:00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Liste des cours
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  final course = _courses[index];
                  return Card(
                    color: AppColors.lightPurple,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        course["title"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(course["time"]!),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Todo: Add action
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  const Text(
                    "Planning de la Semaine",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScheduleRow(
                            "Lundi", "10:00 - 12:00", "JavaScript"),
                        _buildScheduleRow(
                            "Mercredi", "14:00 - 16:00", "Flutter"),
                        _buildScheduleRow(
                            "Vendredi", "09:00 - 11:00", "Sécurité Web"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleRow(String day, String time, String course) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(time),
          Text(course),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CoursesPage(),
  ));
}
