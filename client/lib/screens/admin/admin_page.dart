import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to the Admin Page!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Here, you can manage user accounts, events, and more.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Exemple d'action, tu peux ajouter la logique que tu veux ici.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Action executed!')),
                );
              },
              child: const Text("Perform an Action"),
            ),
          ],
        ),
      ),
    );
  }
}
