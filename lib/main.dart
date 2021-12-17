import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/pages/login.dart';
import 'package:login_sprint1/pages/signup.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/login', routes: {
    '/signup': (context) => SignUp(),
    '/login': (context) => LoginPage(),
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
