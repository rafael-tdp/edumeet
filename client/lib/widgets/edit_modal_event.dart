import 'package:client/core/models/event.dart';
import 'package:flutter/material.dart';

class EditEventDialog extends StatefulWidget {
  final Event event;
  final void Function(
      Map<String, dynamic> updatedEvent,
      void Function(bool shouldClose, String? errorMessage, bool isLoading) callback,
      ) onUpdate;

  const EditEventDialog({required this.event, required this.onUpdate, Key? key})
      : super(key: key);

  @override
  _EditEventDialogState createState() => _EditEventDialogState();
}

class _EditEventDialogState extends State<EditEventDialog> {
  final TextEditingController _titleController = TextEditingController();
  bool _isPrivate = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.event.title ?? '';
    _isPrivate = widget.event.isPrivate ?? false;
  }

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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Modifier l\'événement',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Privé'),
                Switch(
                  value: _isPrivate,
                  onChanged: (value) {
                    setState(() {
                      _isPrivate = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                widget.onUpdate(
                  {
                    'title': _titleController.text,
                    'isPrivate': _isPrivate,
                  },
                  _updateState,
                );
              },
              child: const Text('Mettre à jour'),
            ),
          ],
        ),
      ),
    );
  }
}
