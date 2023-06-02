import 'package:flutter/material.dart';
import 'package:fyp/widgets/custom_row.dart';

class CustomBottomModal extends StatelessWidget {
  final Function()? onPressed;
  const CustomBottomModal({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onPressed,
              child: const CustomRow(
                icon: Icons.photo_library_rounded,
                buttonText: 'Choose Image from Gallery',
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: const CustomRow(
                icon: Icons.photo_camera_rounded,
                buttonText: 'Take Image from Camera',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const CustomRow(
                icon: Icons.cancel,
                buttonText: 'Close',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
