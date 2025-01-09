import 'package:client/screens/document_viewer_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/core/models/document.dart';
import 'package:client/core/services/document_services.dart';

import '../i18n/generated/translations.g.dart';

class FavoriteDocumentsPage extends StatefulWidget {
  const FavoriteDocumentsPage({Key? key}) : super(key: key);
  static const String routeName = '/favorite-documents';

  static navigateTo(BuildContext context) {
    context.push(routeName);
  }

  State<FavoriteDocumentsPage> createState() => _FavoriteDocumentsPageState();
}

class _FavoriteDocumentsPageState extends State<FavoriteDocumentsPage> {
  List<Document> documents = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDocuments();
  }

  void _fetchDocuments() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedDocuments = await DocumentServices.getLikedDocuments();
      setState(() {
        documents = fetchedDocuments;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Erreur lors du chargement des documents.";
        isLoading = false;
      });
    }
  }

  void _openDocumentDetails(BuildContext context, Document document) async {
    final route =
        DocumentViewerPage.routeName.replaceFirst(':documentId', document.id);

    await context.push(
      route,
      extra: {
        'eventId': document.eventId,
        'name': document.name,
        'type': document.type,
        'isLiked': true,
      },
    );

    _fetchDocuments();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(t.app.favoriteDocuments),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.purple,
              ),
            )
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : documents.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucun document favori trouvé",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        return ListTile(
                          leading: const Icon(Icons.insert_drive_file,
                              color: AppColors.purple),
                          title: Text(document.name),
                          // subtitle: Text('Type: ${document.type}'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            _openDocumentDetails(context, document);
                          },
                        );
                      },
                    ),
    );
  }
}
