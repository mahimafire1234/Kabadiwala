import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/pages/signup.dart';
import 'package:login_sprint1/pages/viewcompany.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/viewcompany',
      routes: {
        '/signup': (context) => SignUp(),
        '/viewcompany': (context) => ViewCompany(),
      }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Main(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  bool hidePassword = true;
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.blue;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                  child: TextFormField(
                    decoration: InputDecoration(
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2.0)),
                        prefixIcon: Icon(
                          CupertinoIcons.envelope,
                          color: Color(0xFF000000),
                        ),
                        labelText: "Email Address",
                        contentPadding: EdgeInsets.only(left: 80.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                child: Center(
                  child: TextFormField(
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Color(0xFF000000),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;

                              // hidePassword == true
                              //     ? hidePassword = false
                              //     : hidePassword = true;
                            });
                          },
                          child: hidePassword == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        labelText: "Enter Password",
                        contentPadding: EdgeInsets.only(left: 80.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: checkValue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkValue = !checkValue;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          checkValue = !checkValue;
                        });
                      },
                      child: Text(
                        "Remember Me",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {},
                child: Text(
                  "Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
