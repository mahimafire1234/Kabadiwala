import 'package:flutter/material.dart';

class SetInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Title(
            color: Colors.blue,
            child: const Text("hi"),
            title: "Set information",
          ),
        ),
      ),
    );
  }
}
