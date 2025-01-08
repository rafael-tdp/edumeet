import 'package:client/core/services/document_services.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';
import 'package:go_router/go_router.dart';

class DocumentViewerPage extends StatefulWidget {
  static const String routeName = '/document/:documentId';

  static navigateTo(BuildContext context, String eventId, String documentId,
      String name, String type, bool isLiked) {
    final route = routeName.replaceFirst(':documentId', documentId);

    context.push(
      route,
      extra: {
        'eventId': eventId,
        'name': name,
        'type': type,
        'isLiked': isLiked,
      },
    );
  }

  final String documentId;

  const DocumentViewerPage({
    super.key,
    required this.documentId,
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  late Future<String> _documentContent;
  late String? documentName;
  late String? documentType;
  late bool? isLiked;

  @override
  void initState() {
    super.initState();
    _documentContent = DocumentServices.getDocumentContent(widget.documentId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    documentName = extra?['name'];
    documentType = extra?['type'];
    isLiked = extra?['isLiked'];
  }

  List<Widget> _parseDocumentContent(String content) {
    final lines = content.split('\n');
    List<Widget> widgets = [];

    for (var line in lines) {
      if (line.toLowerCase().startsWith('énoncé :') ||
          line.toLowerCase().startsWith('énoncé:')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Énoncé: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: line
                        .replaceAll('Énoncé:', '')
                        .replaceAll('énoncé:', '')
                        .trim(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (line.toLowerCase().startsWith('correction :') ||
          line.toLowerCase().startsWith('correction:')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Correction: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        widgets.add(
          Text(
            line.trim(),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        );
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(documentName ?? "Document",
            style: const TextStyle(color: Colors.black, fontSize: 16)),
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
              final widgets = _parseDocumentContent(snapshot.data!);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLiked == true
                ? DocumentServices.unlikeDocument(widget.documentId)
                : DocumentServices.likeDocument(widget.documentId);
            isLiked = !isLiked!;
          });
        },
        backgroundColor: AppColors.white,
        // rounded
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLiked == true
            ? const Icon(Icons.favorite, color: Colors.red)
            : const Icon(Icons.favorite_border, color: Colors.red),
      ),
    );
  }
}
