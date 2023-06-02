import 'package:flutter/material.dart';

class ItemsDetail extends StatelessWidget {
  static String route = '/items_screen';
  const ItemsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant\'s Name'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset('assets/images/plant.png'),
          ),
          const Expanded(
            child: Column(
              children: [
                Text('Name of the plant'),
                Text('Price of the Plant'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
