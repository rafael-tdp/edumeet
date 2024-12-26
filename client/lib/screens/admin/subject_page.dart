import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';


class Subject {
  final int id;
  final String name;

  Subject({required this.id, required this.name});
}

class SubjectPage extends StatelessWidget {
  final List<Subject> subjects = [
    Subject(id: 1, name: 'Mathématiques'),
    Subject(id: 2, name: 'Physique'),
    Subject(id: 3, name: 'Chimie'),
    Subject(id: 4, name: 'Biologie'),
    Subject(id: 5, name: 'Informatique'),
    Subject(id: 6, name: 'Histoire'),
    Subject(id: 7, name: 'Géographie'),
    Subject(id: 8, name: 'Philosophie'),
    Subject(id: 9, name: 'Anglais'),
    Subject(id: 10, name: 'Espagnol'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Subjects'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTableWithPagination<Subject>(
          data: subjects,
          initialRowsPerPage: 5,
          columns: const [
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('Name')),
          ],
          rowBuilder: (subject) {
            return [
              DataCell(Text(subject.id.toString())),
              DataCell(Text(subject.name)), 
            ];
          },
        ),
      ),
    );
  }
}