import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/bottom_navigationbar.dart';
import 'package:fyp/screens/forgot_password_screen.dart';
import 'package:fyp/screens/signup_screen.dart';
import 'package:fyp/widgets/custom_button.dart';
import 'package:fyp/widgets/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class LogInScreen extends StatefulWidget {
  static String route = '/login_screen';
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  signUserIn() async {
    //  Show the loading Spinner.
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Lottie.asset('assets/images/loading_animation.json'),
      ),
    );

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showErrorMessage(
        'Please make sure you are connected to an active Internet',
      );
    }

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then(
          (value) => Navigator.pushReplacementNamed(context, BottomTab.route),
        )
        .catchError(
      (error) {
        //debugPrint('inside the catch block');
        if (error is FirebaseAuthException) {
          debugPrint(error.code);
          if (error.code == 'user-not-found' ||
              error.code == 'wrong-password' ||
              error.code == 'invalid-email') {
            showErrorMessage(error.message.toString());
          }
        }
        return '';
      },
    );
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
                  Lottie.asset(
                    'assets/images/water.json',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    'Welcome Back! 😊',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      fontFamily: 'Sora',
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ForgotPasswordScreen.route,
                          );
                        },
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.only(right: 0.0),
                          ),
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    onTap: signUserIn,
                    message: 'Log In',
                  ),
                  const SizedBox(height: 15.0),
                  Divider(
                    color: Colors.green.shade300,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUpScreen.route);
                        },
                        child: Text(
                          'Register Now',
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
