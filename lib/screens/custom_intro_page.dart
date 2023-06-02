import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  final String lottieUrl;
  final String message;
  final String onBoardingMessage;
  const IntroScreen(
      {super.key,
      required this.lottieUrl,
      required this.message,
      required this.onBoardingMessage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Lottie.asset(
            'assets/images/$lottieUrl.json',
            height: 300.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            onBoardingMessage,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Container(
            height: 170.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.20),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.90,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
