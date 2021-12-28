import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/pages/base.dart';
import 'package:login_sprint1/pages/insertrate.dart';
import 'package:login_sprint1/pages/login.dart';
import 'package:login_sprint1/pages/myprofilekabadiwala.dart';
import 'package:login_sprint1/pages/oneCompany.dart';
import 'package:login_sprint1/pages/priceview.dart';
import 'package:login_sprint1/pages/ratespage.dart';
import 'package:login_sprint1/pages/set_information.dart';
import 'package:login_sprint1/pages/signup.dart';
import 'package:login_sprint1/pages/viewcompany.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/viewcompany",
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => LoginPage(),
        '/home': (context) => const Base(index: 0),
        '/viewcompany': (context) => const ViewCompany(),
        // '/onecompany': (context) => const oneCompany(),
        // '/insertrate': (context) => const InsertRate(),
        // '/priceview': (context) => const PriceView(),
        '/myprofilekabadiwala': (context) => const CompanyProfile(),
        "/setInfo": (context) => SetInformation(),
        // "/ratespage": (context) => Rates(),
        "/setInfo": (context) => const Base(index: 0)
      },
    );
  }
}
