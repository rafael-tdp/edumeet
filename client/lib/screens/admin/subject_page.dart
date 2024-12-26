import 'package:client/core/models/subject.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';

class SubjectPage extends StatefulWidget {
  static const String routeName = '/subjects';
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Subject> _subjects = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
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
      print('Error fetching subjects: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        title: const Text('Liste des Subjects'),
        backgroundColor: AppColors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _subjects.isEmpty
            ? const Center(child: Text('Aucun sujet disponible'))
            : DataTableWithPagination<Subject>(
          data: _subjects,
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