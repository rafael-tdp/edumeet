import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final bool rounded;
  final bool isLoader;
  final VoidCallback onPressed;

  const ProfileButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.isLoader = false,
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
      child: isLoader
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
    );
  }
}
