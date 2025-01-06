import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = "Confirmer",
    String cancelText = "Annuler",
    Color confirmColor = Colors.green,
    Color cancelColor = Colors.red,
    IconData? icon,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Wrap(
            children: [
              if (icon != null) Icon(icon, color: confirmColor),
              if (icon != null) const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                cancelText,
                style: TextStyle(color: cancelColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText, style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
