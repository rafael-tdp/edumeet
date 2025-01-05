import 'package:client/core/models/user.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/screens/create_event_screen.dart';
import 'package:client/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/core/services/event_services.dart';
import 'package:provider/provider.dart';

class CreateDocumentsPage extends StatefulWidget {
  static const String routeName = '/documents';

  static navigateTo(BuildContext context, String eventId) {
    context.push(
        '${EventsPage.routeName}${CreateEventPage.routeName}$routeName',
        extra: eventId);
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
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    if (!mounted) return;
    _currentUser =
        await Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  void dispose() {
    _exerciseController.dispose();
    super.dispose();
  }

  Future<void> _generateExo(context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await EventServices.generateExo(widget.eventId);
      setState(() {
        _exercise = response;
        _exerciseController.text = _exercise!;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Erreur lors de la génération de l\'exercice: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _generateCorrection(context) async {
    if (_exercise == null || _exercise!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Veuillez d\'abord générer ou modifier un exercice.')),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await EventServices.generateCorrection(
          widget.eventId, _exerciseController.text);
      setState(() {
        _correction = response;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Erreur lors de la génération de la correction: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _confirmDocumentsContent(BuildContext context, VoidCallback onSuccess) async {
    if (_exercise == null || _exercise!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Veuillez d\'abord générer ou modifier un exercice.')),
      );
      return;
    }
    if (_correction == null || _correction!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Veuillez d\'abord générer la correction.')),
      );
      return;
    }

    try {
      await Future.wait([
        EventServices.saveDocument(
            widget.eventId, _exerciseController.text, 'EXERCISE'),
        EventServices.saveDocument(widget.eventId, _correction!, 'CORRECTION'),
      ]);
      onSuccess.call();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Erreur lors de la sauvegarde des documents: $error')),
      );
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
                    onPressed: () => _generateExo(context),
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
                    onPressed: (_exercise != null)
                        ? () => _generateCorrection(context)
                        : null,
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
                        const SizedBox(height: 8),
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 300,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _correction!,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _confirmDocumentsContent(context, () {
                      if (!mounted) return;
                      context.go(
                          '${EventsPage.routeName}/${widget.eventId}/details',
                          extra: _currentUser);
                    }),
                    child: const Text("Valider le contenu"),
                  ),
                ],
              ),
      ),
    );
  }
}
