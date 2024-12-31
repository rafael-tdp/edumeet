import 'package:flutter/material.dart';
import 'package:client/core/models/subject.dart';

class DropdownOption {
  final String label;
  final String? value;

  DropdownOption(this.label, this.value);
}

class FiltersComponent extends StatelessWidget {
  final List<Subject> subjects;
  final Function(String?) onEventTypeChanged;
  final Function(double?) onDistanceChanged;
  final Function(String?) onSubjectChanged;
  final String? selectedEventType;
  final String? selectedSubject;

  const FiltersComponent({
    super.key,
    required this.subjects,
    required this.onEventTypeChanged,
    required this.onDistanceChanged,
    required this.onSubjectChanged,
    this.selectedEventType,
    this.selectedSubject,
  });

  @override
  Widget build(BuildContext context) {
    // Options pour les types d'événements avec des valeurs correspondant à un ID
    final eventTypeOptions = [
      DropdownOption("Tous les types", "all"),
      DropdownOption("Physique", "physical"),
      DropdownOption("Virtuel", "virtual"),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 2,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DropdownButton<String>(
            hint: const Text("Type d'événement"),
            value: selectedEventType,
            onChanged: onEventTypeChanged,
            style: const TextStyle(fontSize: 14),
            items: eventTypeOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option.value,
                child: Text(option.label),
              );
            }).toList(),
          ),
          if (selectedEventType == "physical")
            SizedBox(
              width: 100,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Distance",
                  suffixText: "km",
                  labelStyle: TextStyle(fontSize: 14),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => onDistanceChanged(double.tryParse(value)),
              ),
            ),
          DropdownButton<String>(
            hint: const Text("Sujet"),
            value: selectedSubject,
            onChanged: onSubjectChanged,
            style: const TextStyle(fontSize: 14),
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text("Tous les sujets"),
              ),
              ...subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject.id, // Utilisation de l'ID au lieu du nom
                  child: Text(subject.name), // Affichage du nom du sujet
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
