import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';

class ResourcesSection extends StatelessWidget {
  final List<Map<String, String>> resources;

  const ResourcesSection({super.key, required this.resources});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ressources disponibles",
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
                title: Text(resource['title']!),
                subtitle: Text(resource['description']!),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Action à effectuer lors du tap sur une ressource
                  // Par exemple, naviguer vers une page de détails
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
