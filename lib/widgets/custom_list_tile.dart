import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String text;
  const CustomListTile({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: onTap,
      leading: Icon(icon),
      title: Text(text),
      iconColor: Colors.green.shade800,
      visualDensity: VisualDensity.comfortable,
      splashColor: Colors.green.shade300,
    );
  }
}
