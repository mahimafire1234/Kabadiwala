import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final myEmailKey = GlobalKey<FormState>();
  final myPasswordKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  var token = "";

  login() async {
    try {
      email = emailController.text;
      password = passwordController.text;
      Map<dynamic, dynamic> body = {"email": email, "password": password};
      var response = await http
          .post(Uri.parse("http://10.0.2.2:5000/user/login"), body: body);
      // print(response.body);
      var data = json.decode(response.body);
      token = (data["token"]);
      print(token);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("login vayo");
      }
    } catch (e) {
      print(e);
    }
  }

  bool hidePassword = true;
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Center(
                  child: TextFormField(
                    key: myEmailKey,
                    controller: emailController,
                    decoration: const InputDecoration(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                child: Center(
                  child: TextFormField(
                    key: myPasswordKey,
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
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
                        EdgeInsets.symmetric(
                            horizontal: 120.0, vertical: 12.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () => {login()},
                child: Text(
                  "Login",
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  "Forget Password?",
                  style: TextStyle(fontSize: 18, color: Color(0xff0077B6)),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  "Sign in using",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExtractWidget(
                    icon: FontAwesomeIcons.facebook,
                    colour: Colors.blue,
                    onClick: () {},
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  ExtractWidget(
                    icon: FontAwesomeIcons.google,
                    colour: Colors.orangeAccent,
                    onClick: () {},
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  ExtractWidget(
                    icon: FontAwesomeIcons.apple,
                    onClick: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => {Navigator.pushNamed(context, "/signup")},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExtractWidget extends StatelessWidget {
  final IconData? icon;
  final Color? colour;
  final VoidCallback? onClick;
  const ExtractWidget({
    Key? key,
    required this.icon,
    this.colour,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        icon: FaIcon(
          icon,
          color: colour,
        ),
        onPressed: onClick);
  }
}
