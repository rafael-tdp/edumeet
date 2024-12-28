import 'package:client/core/models/subject.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/confirmation_dialog.dart';
import 'package:client/core/models/user.dart';

class UserPageAdmin extends StatefulWidget {
  static const String routeName = '/users';
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPageAdmin> {
  List<User> _users = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await UserServices.getUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching users: $error');
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
              content: 'Êtes-vous sûr de vouloir supprimer cet utilisateur "${subject.name}" ?',
              isLoading: isDeleting,
              onCancel: () {
                Navigator.of(context).pop(); // Fermer la modal
              },
              onConfirm: () async {
                setState(() {
                  isDeleting = true; // Activer le loader
                });
                await SubjectServices.deleteSubject(subject.id);
                setState(() {
                  isDeleting = false;
                });

                Navigator.of(context).pop(); // Fermer la modal

              },
            );
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
        title: const Text('Liste des Utilisateurs'),
        backgroundColor: AppColors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _users.isEmpty
            ? const Center(child: Text('Aucun utilisateur trouvé'))
            : DataTableWithPagination<User>(
          data: _users,
          initialRowsPerPage: 5,
          columns: const [
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Firstname')),
            DataColumn(label: Text('Lastname')),
            DataColumn(label: Text('BirthDate')),
            DataColumn(label: Text('Activated')),
            DataColumn(label: Text('ReportNumber')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Actions')),
          ],
          rowBuilder: (user) {
            return [
              DataCell(Text(user.id.toString())),
              DataCell(Text(user.email)),
              DataCell(Text(user.firstname)),
              DataCell(Text(user.lastname)),
              DataCell(Text(user.birthDate.toString())),
              DataCell(Text(user.activated.toString())),
              DataCell(Text(user.reportNumber.toString())),
              DataCell(Text(user.role.toString())),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Modifier',
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Supprimer',
                    onPressed: () {
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