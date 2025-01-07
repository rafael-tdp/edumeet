import 'package:client/core/models/subject.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';

class SubjectsSelection extends StatefulWidget {
  final Function(Set<String>) onSelected;
  final Set<String> selectedSubjects;

  const SubjectsSelection({
    super.key,
    required this.onSelected,
    this.selectedSubjects = const {},
  });

  @override
  _SubjectsSelectionState createState() => _SubjectsSelectionState();
}

class _SubjectsSelectionState extends State<SubjectsSelection> {
  List<Subject> _subjects = [];
  bool _isLoading = true;
  late Set<String> _selectedSubjects;

  @override
  void initState() {
    super.initState();
    _selectedSubjects = widget.selectedSubjects;
    _fetchSubjects();
  }

  Future<void> _fetchSubjects() async {
    try {
      final subjects = await SubjectServices.getSubjects();
      setState(() {
        _subjects = subjects;
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_subjects.isEmpty) {
      return const Text('Aucun sujet disponible.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionnez les sujets:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        MultiSelectChip(
          subjects: _subjects,
          selectedSubjects: _selectedSubjects,
          onSelectionChanged: (selectedSubjects) {
            setState(() {
              _selectedSubjects = selectedSubjects;
            });
            widget.onSelected(_selectedSubjects);
          },
        ),
      ],
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<Subject> subjects;
  final Set<String> selectedSubjects;
  final ValueChanged<Set<String>> onSelectionChanged;

  const MultiSelectChip({
    super.key,
    required this.subjects,
    required this.selectedSubjects,
    required this.onSelectionChanged,
  });

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  late Set<String> _selectedSubjects;

  @override
  void initState() {
    super.initState();
    _selectedSubjects = widget.selectedSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.subjects.map((subject) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            width: double.infinity,
            child: ChoiceChip(
              label: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    subject.name,
                  ),
                ),
              ),
              selected: _selectedSubjects.contains(subject.id),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSubjects.add(subject.id);
                  } else {
                    _selectedSubjects.remove(subject.id);
                  }
                });
                widget.onSelectionChanged(_selectedSubjects);
              },
              backgroundColor: AppColors.lightPurple,
              selectedColor: AppColors.purple,
            ),
          ),
        );
      }).toList(),
    );
  }
}
