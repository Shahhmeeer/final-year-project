import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fyp/bottom_navigationbar.dart';
import 'package:fyp/firebase_options.dart';
import 'package:fyp/screens/forgot_password_screen.dart';
import 'package:fyp/screens/home_screen.dart';
import 'package:fyp/screens/items_detail_screen.dart';
import 'package:fyp/screens/login_screen.dart';
import 'package:fyp/screens/onboarding_screen.dart';
import 'package:fyp/screens/signup_screen.dart';

void main() async {
  // await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isLoggedIn = false;
  void checkCurrentUser() {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    //debugPrint(user.toString());
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  final GlobalKey<BottomTabState> bottomTabKey = GlobalKey<BottomTabState>();

  @override
  void initState() {
    checkCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant_E Store',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Sora',
      ),
      initialRoute: _isLoggedIn ? BottomTab.route : OnBoardingScreen.route,
      routes: {
        ItemsDetail.route: (context) => const ItemsDetail(),
        OnBoardingScreen.route: (context) => const OnBoardingScreen(),
        BottomTab.route: (context) => BottomTab(key: bottomTabKey),
        LogInScreen.route: (context) => const LogInScreen(),
        SignUpScreen.route: (context) => const SignUpScreen(),
        ForgotPasswordScreen.route: (context) => const ForgotPasswordScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
      },
    );
  }
}
