import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  final screens = [Home(), CompanyProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(
              title: Text("Kabadiwala"),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xff0077B6)),
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
