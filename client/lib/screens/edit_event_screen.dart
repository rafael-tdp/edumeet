import 'package:client/core/models/event.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/components/subjects_selection.dart';
import 'package:client/core/services/event_services.dart';
import 'package:intl/intl.dart';
import 'package:client/core/services/adresse_services.dart';
import 'package:provider/provider.dart';

class EditEventPage extends StatefulWidget {
  final String eventId;

  static const String routeName = '/edit';

  static navigateTo(BuildContext context, String eventId) {
    context.push('${EventsPage.routeName}$routeName/$eventId');
  }

  const EditEventPage({super.key, required this.eventId});

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final _locationController = TextEditingController();
  final _onlineLinkController = TextEditingController();

  bool _isDisposed = false;
  bool _isPrivate = false;
  bool _isPhysical = true;
  Set<String> _selectedSubjects = {};

  List<String> _addressSuggestions = [];

  @override
  void dispose() {
    _isDisposed = true;
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
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

  void _updateEvent(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Event event = Event(
      id: widget.eventId,
      title: _nameController.text,
      description: _descriptionController.text,
      startDate: _startDate!
          .add(Duration(hours: _startTime!.hour, minutes: _startTime!.minute))
          .toIso8601String()
          .replaceFirst(RegExp(r'\.000$'), 'Z'),
      endDate: _endDate!
          .add(Duration(hours: _endTime!.hour, minutes: _endTime!.minute))
          .toIso8601String()
          .replaceFirst(RegExp(r'\.000$'), 'Z'),
      isPrivate: _isPrivate,
      physicalEvent:
          _isPhysical ? {'location': "1 Rue Lecourbe 75015 Paris"} : null,
      remoteEvent: !_isPhysical ? {'url': _onlineLinkController.text} : null,
      subjects: _selectedSubjects.toList(),
    );

    try {
      await EventServices.updateEvent(event);
      final currentUser =
          await Provider.of<UserProvider>(context, listen: false).getUser();
      if (currentUser != null) {
        Navigator.of(context).pop(true);
      } else {
        print("Erreur: utilisateur non trouvé");
      }
    } catch (e) {
      print("Erreur de mise à jour d'événement: $e");
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

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
          print("start time selected: ${_startTime}");
        } else {
          _endTime = selectedTime;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  // Load the event details for editing
  Future<void> _loadEventDetails() async {
    try {
      Event event = await EventServices.getEvent(widget.eventId);
      setState(() {
        _nameController.text = event.title;
        _descriptionController.text = event.description;
        _startDate = DateTime.parse(event.startDate);
        _endDate = DateTime.parse(event.endDate);
        _startTime = TimeOfDay.fromDateTime(_startDate!);
        _endTime = TimeOfDay.fromDateTime(_endDate!);
        _isPrivate = event.isPrivate;
        _isPhysical = event.physicalEvent != null;
        _selectedSubjects = Set.from(event.subjects!);
        if (event.physicalEvent != null) {
          _locationController.text = event.physicalEvent['location']!;
        } else {
          _onlineLinkController.text = event.remoteEvent['url']!;
        }
      });
      print("start time: ${_startDate}");
    } catch (e) {
      print("Erreur de chargement de l'événement: $e");
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
        title: const Text(
          "Modifier l'événement",
          style: TextStyle(
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
              _buildTimeField(
                context,
                label: "Heure de début",
                isStartTime: true,
              ),
              _buildTimeField(
                context,
                label: "Heure de fin",
                isStartTime: false,
              ),
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
              SwitchListTile(
                title: const Text("Événement privé"),
                value: _isPrivate,
                onChanged: (bool value) {
                  setState(() {
                    _isPrivate = value;
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
                onPressed: () => _updateEvent(context),
                child: const Text("Enregistrer"),
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

  Widget _buildTimeField(
    BuildContext context, {
    required String label,
    required bool isStartTime,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          _selectTime(context, isStartTime);
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: isStartTime
                ? TextEditingController(
                    text: _startTime == null ? '' : _startTime!.format(context),
                  )
                : TextEditingController(
                    text: _endTime == null ? '' : _endTime!.format(context),
                  ),
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              prefixIcon: const Icon(Icons.access_time),
            ),
          ),
        ),
      ),
    );
  }
}
