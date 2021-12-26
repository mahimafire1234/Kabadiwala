import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/pages/myprofilekab.dart';
import 'package:login_sprint1/pages/login.dart';
import 'package:login_sprint1/pages/signup.dart';
import 'package:login_sprint1/pages/viewcompany.dart';
import 'package:login_sprint1/pages/insertrate.dart';
import 'package:login_sprint1/pages/priceview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/insertrate",
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => LoginPage(),
        '/viewcompany': (context) => const ViewCompany(),
        '/insertrate': (context) => const InsertRate(),
        '/priceview': (context) => const PriceView(),
        '/myprofilekab':(context) => const MyProfile(),
      },
    );
  }
}
