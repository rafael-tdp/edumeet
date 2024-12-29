import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/services/subjects_services.dart';

class CreateSubjectModal extends StatefulWidget {
  const CreateSubjectModal({Key? key}) : super(key: key);

  @override
  _CreateSubjectModalState createState() => _CreateSubjectModalState();
}

class _CreateSubjectModalState extends State<CreateSubjectModal> {
  final TextEditingController _nameController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _createSubject() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    bool response = await SubjectServices.createSubject(_nameController.text);

    setState(() {
      _isLoading = false;
    });

    if (response) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Matière crée avec succes')),
      );
    } else {
      setState(() {
        _errorMessage = 'Une erreur est survenue';
      });
    }
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _createSubject,
          child: const Text('Valider'),
        ),
      ],
    );
  }
}
