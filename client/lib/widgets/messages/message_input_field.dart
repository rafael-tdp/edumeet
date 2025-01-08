import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';

class MessageInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSendMessage,
  });

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onSubmitted: (_) => widget.onSendMessage(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: t.messages.writeMessageHint,
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
          icon: Icon(
            Icons.send,
            color: widget.controller.text.isEmpty ? Colors.grey : AppColors.purple,
          ),
          onPressed: widget.controller.text.isEmpty ? null : widget.onSendMessage,
        ),
      ),
    );
  }
}