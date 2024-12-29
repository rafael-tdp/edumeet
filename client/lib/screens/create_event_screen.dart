import 'package:client/core/models/event.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/create_documents_screen.dart';
import 'package:client/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/components/subjects_selection.dart';
import 'package:client/core/services/event_services.dart';
import 'package:intl/intl.dart';
import 'package:client/core/services/adresse_services.dart';

class CreateEventPage extends StatefulWidget {
  static const String routeName = '/create';

  static navigateTo(BuildContext context) {
    context.push('${EventsPage.routeName}$routeName');
  }

  const CreateEventPage({super.key});

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final _locationController = TextEditingController();
  // final _maxParticipantsController = TextEditingController();
  final _onlineLinkController = TextEditingController();

  bool _isDisposed = false;
  bool _isPrivate = false;
  bool _isPhysical = true;
  Set<String> _selectedSubjects = {};

  // Liste pour stocker les suggestions d'adresses
  List<String> _addressSuggestions = [];

  @override
  void dispose() {
    _isDisposed = true;
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    // _maxParticipantsController.dispose();
    _onlineLinkController.dispose();
    super.dispose();
  }

  void _getAddressSuggestions(String query) async {
    try {
      if (query.length < 3) {
        return;
      }

      List<String> suggestions = await fetchAddressSuggestions(query);
      if (!mounted || _isDisposed) {
        return;
      }
      setState(() {
        _addressSuggestions = suggestions;
      });
    } catch (e) {
      print("Erreur de récupération des adresses: $e");
    }
  }

  void _createEvent(context) async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Event event = Event(
      title: _nameController.text,
      description: _descriptionController.text,
      startDate: _startDate!.toIso8601String().replaceFirst(RegExp(r'\.000$'), 'Z'),
      endDate: _endDate!.toIso8601String().replaceFirst(RegExp(r'\.000$'), 'Z'),
      isPrivate: _isPrivate,
      // nbMaxParticipants: int.parse(_maxParticipantsController.text),
      physicalEvent: _isPhysical
          ? {
              'location':
                  "1 Rue Lecourbe 75015 Paris" //_locationController.text,
            }
          : null,
      remoteEvent: !_isPhysical
          ? {
              'url': _onlineLinkController.text,
            }
          : null,
      subjects: _selectedSubjects.toList(),
    );

    try {
      var createdEvent = await EventServices.createEvent(event);
      final eventId = createdEvent.id;
      CreateDocumentsPage.navigateTo(context, eventId!);
    } catch (e) {
      print("Erreur de création d'événement: $e");
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go(EventsPage.routeName);
          },
        ),
        title: Text(
          t.event.createEvent,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                controller: _nameController,
                label: t.event.name,
                icon: Icons.event,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterName;
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _descriptionController,
                label: t.event.description,
                icon: Icons.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterDescription;
                  }
                  return null;
                },
              ),
              _buildDateField(
                context,
                label: "Date de début",
                isStartDate: true,
              ),
              _buildDateField(
                context,
                label: "Date de fin",
                isStartDate: false,
              ),
              // _buildTextFormField(
              //   controller: _maxParticipantsController,
              //   label: t.event.maxParticipants,
              //   icon: Icons.people,
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return t.event.enterMaxParticipants;
              //     }
              //     if (int.tryParse(value) == null) {
              //       return t.event.invalidMaxParticipants;
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("Événement physique"),
                value: _isPhysical,
                onChanged: (bool value) {
                  setState(() {
                    _isPhysical = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              _isPhysical
                  ? _buildTextFormField(
                      controller: _locationController,
                      label: t.event.location,
                      icon: Icons.location_on,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.event.enterLocation;
                        }
                        return null;
                      },
                      onChanged: _getAddressSuggestions,
                    )
                  : _buildTextFormField(
                      controller: _onlineLinkController,
                      label: "Lien de connexion",
                      icon: Icons.link,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer un lien de connexion.";
                        }
                        return null;
                      },
                    ),
              // Affichage des suggestions d'adresses
              if (_addressSuggestions.isNotEmpty)
                Column(
                  children: _addressSuggestions.map((suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        _locationController.text = suggestion;
                        setState(() {
                          _addressSuggestions.clear();
                        });
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300.0,
                child: SingleChildScrollView(
                  child: SubjectsSelection(
                    onSelected: (selectedSubjects) {
                      setState(() {
                        _selectedSubjects = selectedSubjects;
                      });
                    },
                    selectedSubjects: _selectedSubjects,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _createEvent(context),
                child: Text(t.event.create),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    required String label,
    required bool isStartDate,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context, isStartDate);
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: isStartDate
                ? TextEditingController(
                    text: _startDate == null
                        ? ''
                        : DateFormat('yyyy-MM-dd').format(_startDate!),
                  )
                : TextEditingController(
                    text: _endDate == null
                        ? ''
                        : DateFormat('yyyy-MM-dd').format(_endDate!),
                  ),
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              prefixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }
}
