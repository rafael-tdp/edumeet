import 'package:client/core/models/badge.dart' as Model;
import 'package:client/core/services/badges_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:client/widgets/edit_modal_badge.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/response.dart';
import '../../widgets/confirmation_dialog.dart';

class BadgePage extends StatefulWidget {
  static const String routeName = '/badges';
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  List<Model.Badge> _badges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBadges();
  }

  Future<void> _fetchBadges() async {
    try {
      final badges = await BadgeServices.getBadges();
      setState(() {
        _badges = badges;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching badges: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDeleteConfirmation(BuildContext context, Model.Badge badge) {
    bool isDeleting = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConfirmationDialog(
              title: 'Confirmer la suppression',
              content: 'Êtes-vous sûr de vouloir supprimer le Badge "${badge.name}" ?',
              isLoading: isDeleting,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onConfirm: () async {
                setState(() {
                  isDeleting = true;
                });
                await Future.delayed(const Duration(seconds: 2));

                ResponseRequest response = await BadgeServices.deleteBadge(badge.id);

                setState(() {
                  isDeleting = false;
                });

                if (response.success) {
                  _fetchBadges();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Badge supprimé avec succes')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response.message ?? 'Une erreur s\'est produite')),
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

  void _showEditBadgeDialog(BuildContext context, Model.Badge badge) {
    showDialog(
      context: context,
      builder: (context) {
        return EditBadgeDialog(
          initialBadge: badge,
          onSave: (newBadge, callback) async {
            callback(false, null, true);

            await Future.delayed(const Duration(seconds: 2));

            try {
              ResponseRequest response = await BadgeServices.updateBadge(badge, newBadge);

              if (response.success) {
                _fetchBadges();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Badge mis a jour')),
                );

                callback(true, null, false);
              } else {
                callback(false, response.message ?? 'Une erreur s\'est produite', false);
              }
            } catch (e) {
              callback(false, e.toString(), false);
            }
          },
        );
      },
    );
  }


  void _showCreateBadgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditBadgeDialog(
          onSave: (newBadge, callback) async {
            callback(false, null, true);

            await Future.delayed(const Duration(seconds: 2));
            try {
             ResponseRequest response =  await BadgeServices.createBadge(newBadge);

              if (response.success) {
                _fetchBadges();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Badge mis a jour')),
                );

                callback(true, null, false);
              } else {
                callback(false, response.message ?? 'Une erreur s\'est produite', false);
              }
            } catch (e) {
              callback(false, e.toString(), false);
            }
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
        title: const Text('Liste des Badges'),
        backgroundColor: AppColors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showCreateBadgeDialog(context);
                  },
                  child: const Text('Créer un Badge', style: TextStyle(color: AppColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _badges.isEmpty
                ? const Center(child: Text('Aucune données disponible'))
                : DataTableWithPagination<Model.Badge>(
              data: _badges,
              initialRowsPerPage: 5,
              columns: const [
                DataColumn(label: Text('Id')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Nb requirement event')),
                DataColumn(label: Text('SVG')),
                DataColumn(label: Text('Actions')),
              ],
              rowBuilder: (badge) {
                return [
                  DataCell(Text(badge.id)),
                  DataCell(Text(badge.name)),
                  DataCell(Text(badge.type)),
                  DataCell(Text(badge.nbRequirementEvent.toString())),
                  DataCell(
                    SvgPicture.string(
                      badge.svg,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: 'Modifier',
                        onPressed: () {
                          _showEditBadgeDialog(context, badge);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Supprimer',
                        onPressed: () {
                          _showDeleteConfirmation(context, badge);
                        },
                      ),
                    ],
                  )),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}