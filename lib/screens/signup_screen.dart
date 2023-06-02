import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/bottom_navigationbar.dart';
import 'package:fyp/screens/login_screen.dart';
import 'package:fyp/widgets/custom_button.dart';
import 'package:fyp/widgets/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  static String route = '/signup_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void signUserUp() async {
    //  Show the loading Spinner.
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Lottie.asset('assets/images/loading_animation.json'),
      ),
    );

    // Checking the network connectivity.
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      //Navigator.of(context).pop();
      showErrorMessage(
        'Please make sure you are connected to an active Internet',
      );

      return;
    }

    // trying to log user in.
    if (_passwordController.text == _confirmPasswordController.text) {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final String? userId = userCredential.user?.uid;
      addUserDetails(
        _usernameController.text,
        _emailController.text,
        userId.toString(),
      );
      Navigator.of(context).pushReplacementNamed(BottomTab.route);
    } else {
      Navigator.of(context).pop();
      showErrorMessage('Password do not match');
    }
  }

  Future addUserDetails(String userName, String email, String userId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    try {
      await userRef.set({
        'username': userName,
        'email': email,
      });
      debugPrint('Data has been stored to the Firestore');
    } catch (error) {
      debugPrint('There was an error: $error');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Oops'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.0,
                    child: Lottie.asset(
                      'assets/images/walking.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    'Let\'s get you started! 😃',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sora',
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  CustomTextField(
                    controller: _usernameController,
                    hintText: 'Your Name',
                    obsureText: false,
                    isPasswordType: false,
                  ),
                  const SizedBox(height: 15.0),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Your Email',
                    obsureText: false,
                    isPasswordType: false,
                  ),
                  const SizedBox(height: 15.0),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obsureText: true,
                    isPasswordType: true,
                  ),
                  const SizedBox(height: 15.0),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obsureText: true,
                    isPasswordType: true,
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    onTap: signUserUp,
                    message: 'Register',
                  ),
                  const SizedBox(height: 15.0),
                  Divider(
                    color: Colors.green.shade300,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LogInScreen.route);
                        },
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
