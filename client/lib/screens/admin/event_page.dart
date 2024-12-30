import 'package:client/core/models/event.dart';
import 'package:client/core/models/subject.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/edit_modal_subject.dart';

class EventsPageAdmin extends StatefulWidget {
  static const String routeName = '/events';
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

      final events = await EventServices.getEvents();
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching events: $error');
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
              content: 'Êtes-vous sûr de vouloir supprimer l\'evenement "${event.title}" ?',
              isLoading: isDeleting,
              onCancel: () {
                Navigator.of(context).pop(); // Fermer la modal
              },
              onConfirm: () async {
                setState(() {
                  isDeleting = true; // Activer le loader
                });
                bool isDeleted = await EventServices.deleteEvent(event.id);
                setState(() {
                  isDeleting = false;
                });

                if(isDeleted) {
                  _fetchEvents();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Badge supprimé avec succes')),
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
        title: const Text('Liste des Evenements'),
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