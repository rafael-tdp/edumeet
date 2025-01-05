import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isLoading;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: isLoading
          ? const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      )
          : Text(content),
      actions: [
        if (!isLoading) ...[
          TextButton(onPressed: onCancel, child: const Text('Annuler')),
          TextButton(onPressed: onConfirm, child: const Text('Confirmer')),
        ],
      ],
    );
  }
}
