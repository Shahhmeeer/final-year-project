import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String message;
  const CustomButton({super.key, required this.onTap, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        onPressed: onTap,
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.all(14.0),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
