import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/custom_button.dart';
import 'package:fyp/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String route = '/forgot_password_screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordController = TextEditingController();

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  Future _resetPassword() async {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: _forgotPasswordController.text,
          )
          .then(
            (value) => showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('The reset link has been sent successfully!'),
                content: Text(
                  'Check your email for the reset link. Do check you spam folder in case you don\'t see the reset link',
                ),
              ),
            ),
          );
    } on FirebaseAuthException catch (error) {
      debugPrint(error.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            error.message.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/forgot_password_image.jpg',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      const Text('It\'s okay. We got you covered! 😎'),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: const Text(
                          'Enter your email and we will send you a reset link!',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      CustomTextField(
                        controller: _forgotPasswordController,
                        hintText: 'Your Email',
                        obsureText: false,
                        isPasswordType: false,
                      ),
                      const SizedBox(height: 15.0),
                      CustomButton(
                        onTap: _resetPassword,
                        message: 'Reset Password',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
