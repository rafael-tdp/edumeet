import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/core/models/badge.dart' as Model;

class EditBadgeDialog extends StatefulWidget {
  final Model.Badge? initialBadge;
  final void Function(Model.Badge newBadge) onSave;

  const EditBadgeDialog({
    Key? key,
    required this.onSave,
    this.initialBadge,
  }) : super(key: key);

  @override
  _EditBadgeDialogState createState() => _EditBadgeDialogState();
}

class _EditBadgeDialogState extends State<EditBadgeDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _nbRequirementEventController;
  late TextEditingController _svgController;
  bool _isSaving = false;
  String? _selectedType;

  @override
  void initState() {
    super.initState();

    if (widget.initialBadge != null) {
      _nameController = TextEditingController(text: widget.initialBadge!.name);
      _nbRequirementEventController = TextEditingController(text: widget.initialBadge!.nbRequirementEvent.toString());
      _svgController = TextEditingController(text: widget.initialBadge!.svg);
      _selectedType = widget.initialBadge!.type;
    } else {
      _nameController = TextEditingController();
      _nbRequirementEventController = TextEditingController();
      _svgController = TextEditingController();
      _selectedType = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nbRequirementEventController.dispose();
    _svgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40), // Limiter l'espacement horizontal
      child: SizedBox(
        width: 600, // Largeur fixe pour la modal
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.initialBadge == null ? 'Créer un badge' : 'Modifier le badge',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _isSaving
                  ? const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
                  : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le nom ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'EVENT',
                          child: Text('Event'),
                        ),
                        DropdownMenuItem(
                          value: 'USER',
                          child: Text('User'),
                        ),
                        DropdownMenuItem(
                          value: 'MESSAGE',
                          child: Text('Message'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'Le type ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _nbRequirementEventController,
                      decoration: const InputDecoration(
                        labelText: 'Nb Requirement Event',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Filtrer les entrées non numériques
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le nombre d\'événements requis ne peut pas être vide.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _svgController,
                      decoration: const InputDecoration(
                        labelText: 'SVG',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le SVG ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          _isSaving = true;
                        });

                        await Future.delayed(const Duration(seconds: 2));

                        final updatedBadge = Model.Badge(
                          id: widget.initialBadge?.id ?? '',
                          name: _nameController.text,
                          type: _selectedType ?? 'EVENT',
                          nbRequirementEvent: int.parse(_nbRequirementEventController.text),
                          svg: _svgController.text,
                        );

                        widget.onSave(updatedBadge);

                        setState(() {
                          _isSaving = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}