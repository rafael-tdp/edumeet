import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/services/subjects_services.dart';

class CreateSubjectModal extends StatefulWidget {
  final void Function(String subjectName, void Function(bool shouldClose, String? errorMessage, bool isLoading) callback) onSave;

  const CreateSubjectModal({Key? key, required this.onSave}) : super(key: key);

  @override
  _CreateSubjectModalState createState() => _CreateSubjectModalState();
}

class _CreateSubjectModalState extends State<CreateSubjectModal> {
  final TextEditingController _nameController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  void _updateState(bool shouldClose, String? errorMessage, bool isLoading) {
    setState(() {
      _isLoading = isLoading;
      _errorMessage = errorMessage;

      if (shouldClose) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Créer un nouveau sujet'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nom',
              errorText: _errorMessage,
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: CircularProgressIndicator(),
            )
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () {
            widget.onSave(_nameController.text, _updateState);
          },
          child: const Text('Valider'),
        ),
      ],
    );
  }
}
