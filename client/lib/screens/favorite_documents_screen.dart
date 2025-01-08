import 'package:client/screens/document_viewer_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/core/models/document.dart';
import 'package:client/core/services/document_services.dart';

class FavoriteDocumentsPage extends StatelessWidget {
  const FavoriteDocumentsPage({Key? key}) : super(key: key);
  static const String routeName = '/favorite-documents';

  static navigateTo(BuildContext context) {
    context.push(routeName);
  }

  void _openDocumentDetails(BuildContext context, Document document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentDetailsPage(document: document),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Documents favoris'),
      ),
      body: FutureBuilder<List<Document>>(
        future: DocumentServices.getLikedDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.purple,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erreur lors du chargement des documents favoris",
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Aucun document favori trouvé",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final favoriteDocuments = snapshot.data!;
            return ListView.builder(
              itemCount: favoriteDocuments.length,
              itemBuilder: (context, index) {
                final document = favoriteDocuments[index];
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file,
                      color: AppColors.purple),
                  title: Text(document.name),
                  subtitle: Text('Type: ${document.type}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    DocumentViewerPage.navigateTo(
                      context,
                      document.eventId ?? "",
                      document.id,
                      document.name,
                      document.type ?? "",
                      true,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DocumentDetailsPage extends StatelessWidget {
  final Document document;

  const DocumentDetailsPage({Key? key, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Document Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text('Name: ${document.name}'),
            Text('Path: ${document.path}'),
            Text('Type: ${document.type}'),
            Text(
                'Event ID: ${document.eventId!.isNotEmpty ? document.eventId : 'None'}'),
            Text(
                'Message ID: ${document.messageId!.isNotEmpty ? document.messageId : 'None'}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action pour ouvrir ou télécharger le document
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${document.name}...')),
                );
              },
              child: const Text('Open Document'),
            ),
          ],
        ),
      ),
    );
  }
}
