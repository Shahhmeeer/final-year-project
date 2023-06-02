import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/item_card.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  static String route = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _usernameFuture;
  String _username = '';
  String? _greeting;
  final user = FirebaseAuth.instance.currentUser!;
  final documentSnapshot = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
    _usernameFuture = _fetchUsername();
    _setGreeting();
  }

  void _setGreeting() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');
    String formatedTime = formatter.format(now);
    debugPrint(formatedTime);
    if (now.hour >= 0 && now.hour < 12) {
      setState(() {
        _greeting = 'Morning';
      });
    } else if (now.hour >= 12 && now.hour < 18) {
      setState(() {
        _greeting = 'Afternoon';
      });
    } else {
      _greeting = 'Evening';
    }
  }

  Future<void> _fetchUsername() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    debugPrint('inside the future');
    // Fetch the user's details from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      // Set the _username variable to the username retrieved from Firestore
      _username = snapshot.data()?['username'];
    });
    //debugPrint('future resolved');
  }

  final List<String> _categories = [
    'Recommended',
    'On Sale',
    'Indoor Plants',
    'Outdoor Plants',
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _usernameFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Lottie.asset('assets/images/loading_animation.json'),
            );
          case ConnectionState.done:
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_greeting, $_username',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                'Find your perfect plants!',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                            radius: 30.0,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12.0),
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search Plants',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 200,
                              height: 30.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12.0),
                                itemCount: _categories.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) => ItemCard(),
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
            return const Text('There was an error');
        }
      },
    );
  }
}
