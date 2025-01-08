import 'package:flutter/material.dart';

class BannerMessage extends StatelessWidget {
  final bool isVisible;
  final String message;
  final Color backgroundColor;

  const BannerMessage({
    Key? key,
    required this.isVisible,
    required this.message,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: backgroundColor,
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}