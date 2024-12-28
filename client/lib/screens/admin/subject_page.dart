import 'package:client/core/models/subject.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/edit_modal_subject.dart';

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

  void _showDeleteConfirmation(BuildContext context, Subject subject) {
    bool isDeleting = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConfirmationDialog(
              title: 'Confirmer la suppression',
              content: 'Êtes-vous sûr de vouloir supprimer le sujet "${subject.name}" ?',
              isLoading: isDeleting,
              onCancel: () {
                Navigator.of(context).pop(); // Fermer la modal
              },
              onConfirm: () async {
                setState(() {
                  isDeleting = true; // Activer le loader
                });

                bool isDeleted = await SubjectServices.deleteSubject(subject.id);
                setState(() {
                  isDeleting = false;
                });

                if(isDeleted) {
                  _fetchSubjects();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Matière supprimé avec succes')),
                  );
                } else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Une erreur s''est produite pendant la suppression')),
                  );
                }
                Navigator.of(context).pop(); // Fermer la modal
              },
            );
          },
        );
      },
    );
  }

  void _showEditSubjectDialog(BuildContext context, Subject subject) {
    showDialog(
      context: context,
      builder: (context) {
        return EditSubjectDialog(
          initialName: subject.name,
          onSave: (newName) async{
              await SubjectServices.updateSubject(subject, newName);
              _fetchSubjects();
          },
        );
      },
    );
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
            DataColumn(label: Text('Actions')), // Nouvelle colonne
          ],
          rowBuilder: (subject) {
            return [
              DataCell(Text(subject.id.toString())),
              DataCell(Text(subject.name)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Modifier',
                    onPressed: () {
                      _showEditSubjectDialog(context, subject);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Supprimer',
                    onPressed: () {
                      _showDeleteConfirmation(context, subject);
                    },
                  ),
                ],
              )),
            ];
          },
        ),
      ),

    );
  }
}