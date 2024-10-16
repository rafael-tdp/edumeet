import 'package:flutter/material.dart';
import 'package:client/fake_data.dart';
import 'package:client/components/event_card.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Map<String, String>> _courses = FakeData.events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  final course = _courses[index];
                  return EventCard(
                    title: course["title"]!,
                    date: course["date"]!,
                    imageUrl: course["image"]!,
                    participants: course["participants"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
