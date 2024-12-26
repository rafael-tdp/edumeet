import 'package:client/screens/create_event_screen.dart';
import 'package:client/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/core/services/event_services.dart';

class CreateDocumentsPage extends StatefulWidget {
  static const String routeName = '/documents';

  static navigateTo(BuildContext context, String eventId) {
    context.go('${EventsPage.routeName}${CreateEventPage.routeName}$routeName', extra: eventId);
  }

  final String eventId;

  const CreateDocumentsPage({super.key, required this.eventId});

  @override
  _CreateDocumentsPageState createState() => _CreateDocumentsPageState();
}

class _CreateDocumentsPageState extends State<CreateDocumentsPage> {
  String? _exercise;
  String? _correction;
  bool _isLoading = false;
  final TextEditingController _exerciseController = TextEditingController();

  @override
  void dispose() {
    _exerciseController.dispose();
    super.dispose();
  }

  Future<void> _generateExo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await EventServices.generateExo(widget.eventId);
      setState(() {
        _exercise = "Exercice généré pour l'événement ${widget.eventId}"; // Exemple statique
        _exerciseController.text = _exercise!;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la génération de l\'exercice: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _generateCorrection() async {
    if (_exercise == null || _exercise!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez d\'abord générer ou modifier un exercice.')),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await EventServices.generateCorrection(widget.eventId, _exerciseController.text);
      setState(() {
        _correction = "Correction générée pour l'exercice"; // Exemple statique
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la génération de la correction: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Générer des documents"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go(EventsPage.routeName);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _generateExo,
                    child: const Text("Générer un exercice"),
                  ),
                  const SizedBox(height: 16),
                  if (_exercise != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Exercice généré :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: _exerciseController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Modifiez l'exercice ici...",
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: _generateCorrection,
                    child: const Text("Générer la correction"),
                  ),
                  const SizedBox(height: 16),
                  if (_correction != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Correction générée :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _correction!,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                ],
              ),
      ),
    );
  }
}
