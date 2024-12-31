import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/core/models/badge.dart' as Model;

class EditBadgeDialog extends StatefulWidget {
  final Model.Badge? initialBadge;
  final void Function(Model.Badge newBadge, void Function(bool shouldClose, String? errorMessage, bool isLoading)) onSave;

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
  String? _selectedType;
  String? _errorMessage;
  bool _isLoading = false;

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

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: 600,
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
              child: _isLoading
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
                        FilteringTextInputFormatter.digitsOnly,
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
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
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
                    onPressed: _closeDialog,
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final updatedBadge = Model.Badge(
                          id: widget.initialBadge?.id ?? '',
                          name: _nameController.text,
                          type: _selectedType ?? 'EVENT',
                          nbRequirementEvent: int.parse(_nbRequirementEventController.text),
                          svg: _svgController.text,
                        );

                        widget.onSave(
                          updatedBadge,
                              (shouldClose, errorMessage, isLoading) {
                            setState(() {
                              _isLoading = isLoading;
                              _errorMessage = errorMessage;
                            });
                            if (shouldClose) {
                              _closeDialog();
                            }
                          },
                        );
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
