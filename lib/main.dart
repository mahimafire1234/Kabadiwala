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
      body: SafeArea(
        child: Column(
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      fillColor: Colors.black,
                      prefixIcon: Icon(
                        CupertinoIcons.envelope,
                        color: Color(0xFF000000),
                      ),
                      hintText: "Email Address",
                      contentPadding: EdgeInsets.only(left: 80.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 25),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      prefixIcon: Icon(
                        CupertinoIcons.lock,
                        color: Color(0xFF000000),
                      ),
                      suffixIcon: Icon(Icons.visibility_off),
                      hintText: "Enter Password",
                      contentPadding: EdgeInsets.only(left: 80.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
