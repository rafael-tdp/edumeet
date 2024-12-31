import 'package:client/screens/event_details_page.dart';
import 'package:client/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';

class DocumentViewerPage extends StatefulWidget {
  static const String routeName = '/document/:documentId';

  static navigateTo(BuildContext context, String eventId, String documentId) {
    context.push(
      '${EventsPage.routeName}/$eventId/${EventDetailsPage.routeName}/document/$documentId',
    );
  }

  final String documentId;
  final String documentName;

  const DocumentViewerPage({
    super.key,
    required this.documentId,
    required this.documentName,
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  late Future<String> _documentContent;

  @override
  void initState() {
    super.initState();
    _documentContent = EventServices.getDocumentContent(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentName),
        backgroundColor: AppColors.lightPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: _documentContent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.lightPurple,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Erreur lors du chargement du document",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Text(
                  snapshot.data!,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Aucun contenu disponible",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
