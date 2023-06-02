import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/add_item_screen.dart';
import 'package:fyp/screens/home_screen.dart';
import 'package:fyp/screens/orders_screen.dart';
import 'package:fyp/screens/profile_screen.dart';

class BottomTab extends StatefulWidget {
  static String route = '/tabs_screen';
  final GlobalKey<BottomTabState> bottomTabKey = GlobalKey<BottomTabState>();
  BottomTab({Key? key}) : super(key: key);

  @override
  State<BottomTab> createState() => BottomTabState();
}

class BottomTabState extends State<BottomTab> {
  var pageIndex = 0;
  List<Widget> screens = [];
  void goToHome() {
    debugPrint('Home page called');
    setState(() {
      pageIndex = 0;
    });
  }

  @override
  void initState() {
    screens = [
      const HomeScreen(),
      const AddNewItemScreen(),
      OrdersScreen(bottomTabKey: widget.bottomTabKey),
      const ProfileScreen(),
    ];
    super.initState();
  }

  //final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      drawer: Drawer(
        backgroundColor: Colors.green.shade400,
        child: const Column(
          children: [
            DrawerHeader(
              curve: Curves.easeInCirc,
              child: Text("This is the profile side!"),
            ),
            Text(
              'This is going to be the profile page and i have to put all the placeholders in here!',
            ),
            Text('User email address!'),
            Text('Firebase current user and it will give us the user!'),
            Text(
              'Firebase current user, it will return the user and email and status of the user!',
            ),
            Spacer(),
            Text("Users can manage their products in here!"),
            Text(
              'Once the products are managed, the rest can be done with ease!',
            ),
            Text(
              'This will be the section where the user can see the status of their account status and also he/she can manage their products in here!',
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.green.shade300,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        height: 65.0,
        items: [
          Icon(
            Icons.home,
            color: Colors.green.shade900,
          ),
          Icon(
            Icons.add,
            color: Colors.green.shade900,
          ),
          Icon(
            Icons.shopping_bag,
            color: Colors.green.shade900,
          ),
          Icon(
            Icons.person_2_rounded,
            color: Colors.green.shade900,
          ),
        ],
        onTap: (value) => setState(() {
          pageIndex = value;
        }),
      ),
    );
  }
}
