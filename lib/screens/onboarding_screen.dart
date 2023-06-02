import 'package:flutter/material.dart';
import 'package:fyp/screens/custom_intro_page.dart';
import 'package:fyp/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static String route = '/onboarding_screen';
  final String _firstScreenMessage =
      'Welcome to our plant shop! Find the perfect plants to brighten up your space. Explore our selection, and shop with ease.';
  final String _secondScreenMessage =
      'By shopping for plants with us, you are not only improving your own quality of life, but also contributing to a healthier environment';
  final String _lastScreenMessage =
      'Get personalized recommendations, and hassle-free checkout. Join our community of plant lovers and elevate your plant game today!';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool _onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: PageView(
              controller: _controller,
              children: [
                IntroScreen(
                  lottieUrl: 'plant1',
                  message: widget._firstScreenMessage,
                  onBoardingMessage: 'Hey There! 👋',
                ),
                IntroScreen(
                  lottieUrl: 'plant2',
                  message: widget._secondScreenMessage,
                  onBoardingMessage: 'Healthy Environment! 🌼',
                ),
                IntroScreen(
                  lottieUrl: 'plant3',
                  message: widget._lastScreenMessage,
                  onBoardingMessage: 'Secure Payments 💲',
                ),
              ],
              onPageChanged: (value) => setState(() {
                _onLastPage = (value == 2);
              }),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.green.shade100,
                    activeDotColor: Colors.green.shade300,
                    type: WormType.thinUnderground,
                  ),
                ),
                _onLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LogInScreen.route);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
