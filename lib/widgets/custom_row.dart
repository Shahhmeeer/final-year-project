import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final IconData icon;
  final String buttonText;
  const CustomRow({super.key, required this.icon, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10.0),
        Text(buttonText),
      ],
    );
  }
}
