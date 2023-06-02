import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/login_screen.dart';
import 'package:fyp/widgets/custom_list_tile.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _username = '';
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  late Future<void> _usernameFuture;

  @override
  void initState() {
    _usernameFuture = _fetchUsername();
    super.initState();
  }

  void logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LogInScreen.route);
  }

  Future<void> _fetchUsername() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    // Fetch the user's details from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      // Set the _username variable to the username retrieved from Firestore.
      _username = snapshot.data()?['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _usernameFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Inisde the none statement');
          case ConnectionState.waiting:
            return Center(
              child: Lottie.asset('assets/images/loading_animation.json'),
            );
          case ConnectionState.active:
            return const Text('inside the active statement');
          case ConnectionState.done:
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                                radius: 50.0,
                              ),
                              const SizedBox(width: 15.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$_username',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                  Text(
                                    '$userEmail',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast,
                          ),
                          children: [
                            CustomListTile(
                              onTap: () {},
                              icon: Icons.edit,
                              text: 'Edit your profile',
                            ),
                            CustomListTile(
                              onTap: () {},
                              icon: Icons.star,
                              text: 'Rate the App',
                            ),
                            CustomListTile(
                              onTap: () {},
                              icon: Icons.share_rounded,
                              text: 'Share with Friends',
                            ),
                            CustomListTile(
                              onTap: () {},
                              icon: Icons.settings_rounded,
                              text: 'Settings',
                            ),
                            CustomListTile(
                              onTap: () {
                                logOut(context);
                              },
                              icon: Icons.logout_rounded,
                              text: 'Log Out',
                            ),
                            Divider(
                              color: Colors.green.shade800,
                              thickness: 1.0,
                            ),
                            CustomListTile(
                              onTap: () {},
                              icon: Icons.support_agent_rounded,
                              text: 'Customer Support',
                            ),
                            CustomListTile(
                              onTap: () {},
                              icon: Icons.event_note_rounded,
                              text: 'Terms & Conditions',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
