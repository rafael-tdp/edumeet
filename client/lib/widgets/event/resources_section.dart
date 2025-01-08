import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/document_viewer_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';

class ResourcesSection extends StatelessWidget {
  final List<dynamic> resources;
  final String eventId;

  const ResourcesSection(
      {super.key, required this.resources, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.resources.availableResources,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 10),
          ...resources.map((resource) {
            return Card(
              color: AppColors.lightPurple,
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                title: Text(resource['name'] ?? t.resources.name),
                subtitle: Text(resource['type'] ?? t.resources.type),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  DocumentViewerPage.navigateTo(
                    context,
                    eventId,
                    resource['document_id'],
                    resource['name'],
                    resource['type'],
                    resource['is_liked'],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
