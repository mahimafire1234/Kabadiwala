import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Main());
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("app name"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    fillColor: Colors.black,
                    prefixIcon: Icon(
                      CupertinoIcons.envelope,
                      color: Color(0xFF000000),
                    ),
                    hintText: "Email Address",
                    contentPadding: EdgeInsets.only(left: 80.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
