import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/pages/login.dart';
import 'package:login_sprint1/pages/signup.dart';
import 'package:login_sprint1/pages/viewcompany.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => const LoginPage(),
        '/viewcompany': (context) => const ViewCompany(),
      },
    );
  }
}
