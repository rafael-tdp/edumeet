import 'package:client/core/models/subject.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/components/profile_button.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  late Future<List<Subject>> _subjectsFuture;

  final Set<String> _selectedSubjects = {};

  @override
  void initState() {
    super.initState();
    _subjectsFuture = SubjectServices.getSubjects();
  }

  void _toggleSelection(String subjectId) {
    setState(() {
      if (_selectedSubjects.contains(subjectId)) {
        _selectedSubjects.remove(subjectId);
      } else {
        _selectedSubjects.add(subjectId);
      }
    });
  }

  void _confirmSelection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Sujets sélectionnés: ${_selectedSubjects.join(', ')}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: FutureBuilder<List<Subject>>(
            future: _subjectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Aucun sujet trouvé.');
              }

              final subjects = snapshot.data!;

              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Sélectionnez vos sujets préférés',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.purple,
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: subjects.map((subject) {
                          bool isSelected =
                              _selectedSubjects.contains(subject.id);
                          return GestureDetector(
                            onTap: () => _toggleSelection(subject.id),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.purple
                                    : AppColors.lightPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                subject.name,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ProfileButton(
                      text: 'Confirmer',
                      onPressed: _confirmSelection,
                      backgroundColor: AppColors.purple,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
