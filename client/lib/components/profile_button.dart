import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final bool rounded;
  final VoidCallback onPressed;

  const ProfileButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.rounded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 20 : 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
