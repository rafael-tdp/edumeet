import 'package:flutter/material.dart';
import 'package:client/core/models/subject.dart';

class EventFiltersDialog extends StatefulWidget {
  final String? eventType;
  final double? maxDistance;
  final String? selectedSubject;
  final List<Subject> subjects;
  final void Function(String?, double?, String?) onApply;

  const EventFiltersDialog({
    super.key,
    required this.eventType,
    required this.maxDistance,
    required this.selectedSubject,
    required this.subjects,
    required this.onApply,
  });

  @override
  _EventFiltersDialogState createState() => _EventFiltersDialogState();
}

class _EventFiltersDialogState extends State<EventFiltersDialog> {
  String? tempEventType;
  double? tempMaxDistance;
  String? tempSelectedSubject;

  @override
  void initState() {
    super.initState();
    tempEventType = widget.eventType;
    tempMaxDistance = widget.maxDistance;
    tempSelectedSubject = widget.selectedSubject;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filtres"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Type d'événement"),
            DropdownButton<String>(
              value: tempEventType,
              hint: const Text("Sélectionner un type"),
              onChanged: (newValue) {
                setState(() {
                  tempEventType = newValue;
                });
              },
              items: <Map<String, String>>[
                {"Tous les types": "all"},
                {"Physique": "physical"},
                {"Virtuel": "remote"},
              ].map<DropdownMenuItem<String>>((Map<String, String> item) {
                String key = item.keys.first;
                String value = item.values.first;

                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(key),
                );
              }).toList(),
              isExpanded: true,
            ),
            const SizedBox(height: 16),
            if (tempEventType == "physical") ...[
              const Text("Distance maximale (en km)"),
              Slider(
                value: tempMaxDistance ?? 50.0,
                min: 0,
                max: 100,
                divisions: 10,
                label: tempMaxDistance?.toStringAsFixed(1),
                onChanged: (double newValue) {
                  setState(() {
                    tempMaxDistance = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
            const Text("Sujet"),
            DropdownButton<String>(
              value: tempSelectedSubject,
              hint: const Text("Sélectionner un sujet"),
              onChanged: (newValue) {
                setState(() {
                  tempSelectedSubject = newValue;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: "",
                  child: Text("Tous les sujets"),
                ),
                ...widget.subjects.map((subject) {
                  return DropdownMenuItem<String>(
                    value: subject.id,
                    child: Text(subject.name),
                  );
                }).toList(),
              ],
              isExpanded: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onApply(null, null, null);
          },
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(tempEventType, tempMaxDistance, tempSelectedSubject);
          },
          child: const Text("Appliquer"),
        ),
      ],
    );
  }
}
