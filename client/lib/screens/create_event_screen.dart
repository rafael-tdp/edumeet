import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _maxParticipantsController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();

  void _createEvent() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // TODO: Ajouter la logique pour créer un événement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          t.event.createEvent,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
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
              _buildTextFormField(
                controller: _dateController,
                label: t.event.date,
                icon: Icons.calendar_today,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterDate;
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _timeController,
                label: t.event.time,
                icon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterTime;
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _locationController,
                label: t.event.location,
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterLocation;
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _maxParticipantsController,
                label: t.event.maxParticipants,
                icon: Icons.people,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterMaxParticipants;
                  }
                  if (int.tryParse(value) == null) {
                    return t.event.invalidMaxParticipants;
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _priceController,
                label: t.event.price,
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterPrice;
                  }
                  if (double.tryParse(value) == null) {
                    return t.event.invalidPrice;
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _imageController,
                label: t.event.image,
                icon: Icons.image,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.event.enterImage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createEvent,
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
      ),
    );
  }
}
