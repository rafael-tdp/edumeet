import 'package:flutter/material.dart';
import 'package:client/core/models/subject.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/components/subjects_selection.dart';

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

  void _onSubjectsSelected(Set<String> selectedSubjects) {
    setState(() {
      _selectedSubjects.clear();
      _selectedSubjects.addAll(selectedSubjects);
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
              return SubjectsSelection(
                onSelected:
                    _onSubjectsSelected,
                selectedSubjects: _selectedSubjects,
              );
            },
          ),
        ),
      ),
    );
  }
}
