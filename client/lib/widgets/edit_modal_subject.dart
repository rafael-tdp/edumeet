import 'package:flutter/material.dart';

class EditSubjectDialog extends StatefulWidget {
  final String initialName;
  final void Function(String newName, void Function(bool shouldClose, String? errorMessage)) onSave;

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
  String? _errorMessage;

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

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier le sujet'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      actions: [
        TextButton(
          onPressed: _closeDialog,
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSave(
                _nameController.text,
                    (shouldClose, errorMessage) {
                  if (shouldClose) {
                    _closeDialog();
                  } else {
                    setState(() {
                      _errorMessage = errorMessage;
                    });
                  }
                },
              );
            }
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}
