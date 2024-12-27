import 'package:flutter/material.dart';

class EditSubjectDialog extends StatefulWidget {
  final String initialName;
  final void Function(String newName) onSave;

  const EditSubjectDialog({
    Key? key,
    required this.initialName,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditSubjectDialogState createState() => _EditSubjectDialogState();
}

class _EditSubjectDialogState extends State<EditSubjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier le sujet'),
      content: _isSaving
          ? const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      )
          : Form(
        key: _formKey,
        child: TextFormField(
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
      ),
      actions: [
        if (!_isSaving) ...[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer la modal
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                setState(() {
                  _isSaving = true; // Activer le loader
                });

                await Future.delayed(const Duration(seconds: 2)); // Simuler un fetch

                widget.onSave(_nameController.text); // Sauvegarder les modifications

                setState(() {
                  _isSaving = false;
                });

                Navigator.of(context).pop(); // Fermer la modal
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ],
    );
  }
}
