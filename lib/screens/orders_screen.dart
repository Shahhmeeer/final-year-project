import 'package:flutter/material.dart';

import '../bottom_navigationbar.dart';

class OrdersScreen extends StatelessWidget {
  final GlobalKey<BottomTabState> bottomTabKey;
  const OrdersScreen({Key? key, required this.bottomTabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomTabKey = GlobalKey<BottomTabState>(debugLabel: 'bottomTabKey');
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_florist_rounded,
                  size: 100.0,
                  color: Colors.green.shade900,
                ),
                const SizedBox(height: 50.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    'Looks like you haven\'t ordered anything yet.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                ElevatedButton.icon(
                  key: bottomTabKey,
                  onPressed: () {
                    final page = bottomTabKey.currentState?.pageIndex;
                    debugPrint(page.toString());
                    debugPrint('Going to homepage');
                    // Go to the Homepage!
                    bottomTabKey.currentState?.goToHome();
                  },
                  icon: const Icon(Icons.sentiment_very_satisfied_outlined),
                  label: const Text('Continue Shopping!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
