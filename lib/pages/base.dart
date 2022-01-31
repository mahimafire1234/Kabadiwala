import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:login_sprint1/pages/appointment/view_appointment.dart';
import 'package:login_sprint1/pages/booking/booking_request.dart';
import 'package:login_sprint1/pages/user/myprofilekabadiwala.dart';
import 'package:login_sprint1/pages/booking/set_information.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Base extends StatefulWidget {
  final index;
  const Base({Key? key, required this.index}) : super(key: key);

  @override
  _BaseState createState() => _BaseState(index);
}

class _BaseState extends State<Base> {
  int currentIndex;

  _BaseState(this.currentIndex);

  final screens = [
    Home(),
    CompanyProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Kabadiwala"),
          backgroundColor: Color(0xff0077B6)),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(children: [
                Icon(CupertinoIcons.profile_circled, size: 100.0),
                SizedBox(height: 10.0),
                Text(
                  "User name",
                  style: TextStyle(color: Colors.white),
                )
              ]),
            ),
            ListTile(
              leading:
                  Icon(CupertinoIcons.creditcard, color: Color(0xFF000000)),
              title: const Text('Payment History'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.square_arrow_right,
                color: Color(0xFF000000),
              ),
              title: const Text('Logout'),
              onTap: () async {
                // Update the state of the app.
                // ...
                var preferences = await SharedPreferences.getInstance();
                print("preferences ----> $preferences");
                await preferences.clear();
                Navigator.pushNamed(context, "/login");
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
