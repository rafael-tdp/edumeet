import 'package:flutter/material.dart';

class EdumeetButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final bool rounded;
  final bool isLoader;
  final VoidCallback onPressed;
  final Widget? icon;
  final double? width;

  const EdumeetButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.isLoader = false,
    this.rounded = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ? 20 : 3),
          ),
        ),
        child: isLoader
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 10),
                    ],
                    Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
