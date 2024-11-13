import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (_) => onSendMessage(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: 'Ecrivez un message...',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 204, 204, 204),
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 204, 204, 204),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.purple,
            width: 0.5,
          ),
        ),
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.send,
            color: Colors.grey,
          ),
          onPressed: onSendMessage,
        ),
      ),
    );
  }
}
