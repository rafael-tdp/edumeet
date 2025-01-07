import 'package:client/core/models/event.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/response.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/edit_modal_event.dart';

class EventsPageAdmin extends StatefulWidget {
  static const String routeName = '/events';

  const EventsPageAdmin({super.key});
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventsPageAdmin> {
  List<Event> _events = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final events = await EventServices.getEvents([], null, null, "all", null);
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDeleteConfirmation(BuildContext context, Event event) {
    bool isDeleting = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConfirmationDialog(
              title: 'Confirmer la suppression',
              content:
                  'Êtes-vous sûr de vouloir supprimer l\'evenement "${event.title}" ?',
              isLoading: isDeleting,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onConfirm: () async {
                setState(() {
                  isDeleting = true;
                });

                ResponseRequest response =
                    await EventServices.deleteEvent(event.id);

                setState(() {
                  isDeleting = false;
                });

                if (response.success) {
                  _fetchEvents();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Evenement supprimé avec succes')),
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

  void _showEditEventDialog(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => EditEventDialog(
        event: event,
        onUpdate: (updatedEvent, callback) async {
          callback(false, null, true);

          try {
            await Future.delayed(const Duration(seconds: 2));

            ResponseRequest response =
                await EventServices.updateEventAdmin(event.id, updatedEvent);

            if (response.success) {
              _fetchEvents();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Evenement mis a jour')),
              );
              callback(true, null, false);
            } else {
              callback(false, response.message ?? 'Une erreur s\'est produite',
                  false);
            }
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
          'Liste des événements',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _events.isEmpty
                ? const Center(child: Text('Aucun evenement disponible'))
                : DataTableWithPagination<Event>(
                    data: _events,
                    initialRowsPerPage: 5,
                    columns: const [
                      DataColumn(label: Text('Id')),
                      DataColumn(label: Text('StartDate')),
                      DataColumn(label: Text('EndDate')),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('IsPrivate')),
                      DataColumn(label: Text('NbParticipant')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rowBuilder: (event) {
                      return [
                        DataCell(Text(event.id.toString())),
                        DataCell(Text(event.startDate)),
                        DataCell(Text(event.endDate)),
                        DataCell(Text(event.title)),
                        DataCell(Text(event.isPrivate.toString())),
                        DataCell(Text(event.participantsCount.toString())),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              tooltip: 'Modifier',
                              onPressed: () {
                                _showEditEventDialog(context, event);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Supprimer',
                              onPressed: () {
                                _showDeleteConfirmation(context, event);
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
