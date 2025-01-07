import 'package:client/core/services/user_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:client/widgets/edit_modal_user.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/response.dart';
import '../../core/models/user.dart';
import '../../widgets/confirmation_dialog.dart';

import '../../widgets/create_user_modal.dart';

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
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showEditUserDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        return EditUserDialog(
          initialUser: user,
          onSave: (newUser, callback) async {
            callback(false, null, true);

            await Future.delayed(const Duration(seconds: 2));

            try {
              ResponseRequest response =
                  await UserServices.updateAdminUserInfo(newUser);

              if (response.success) {
                _fetchUsers();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Utilisateur modifiée avec succès')),
                );

                callback(true, null, false);
              } else {
                callback(false,
                    response.message ?? 'Une erreur s\'est produite', false);
              }
            } catch (e) {
              callback(false, e.toString(), false);
            }
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, User user) {
    bool isDeleting = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConfirmationDialog(
              title: 'Confirmer la suppression',
              content:
                  'Êtes-vous sûr de vouloir supprimer cet utilisateur "${user.username}" ?',
              isLoading: isDeleting,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onConfirm: () async {
                setState(() {
                  isDeleting = true;
                });

                ResponseRequest response =
                    await UserServices.deleteUser(user.id);
                setState(() {
                  isDeleting = false;
                });

                if (response.success) {
                  _fetchUsers();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Utilisateur supprimé avec succes')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            response.message ?? 'Une erreur s\'est produite')),
                  );
                }
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  void _showCreateUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateUserDialog(
        onCreate: (newUser, callback) async {
          callback(false, null, true);

          try {
            await UserServices.createUser(newUser);
            await _fetchUsers();

            callback(true, null, false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Utilisateur créé avec succès.')),
            );
          } catch (error) {
            callback(false, 'Erreur : $error', false);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      appBar: AppBar(
        title: const Text(
          'Liste des utilisateurs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateUserDialog(context);
        },
        backgroundColor: AppColors.purple,
        child: const Icon(Icons.add, color: Colors.white),
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
                        DataCell(Text(user.email!)),
                        DataCell(Text(user.firstname!)),
                        DataCell(Text(user.lastname!)),
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
                                _showEditUserDialog(context, user);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Supprimer',
                              onPressed: () {
                                _showDeleteConfirmation(context, user);
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
