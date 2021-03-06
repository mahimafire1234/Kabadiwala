import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_sprint1/pages/user/forgot_password.dart';
import 'package:login_sprint1/pages/user/signup.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:login_sprint1/services/userservices.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  // dynamic isLogin = true;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  var token;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  dynamic usertype;

  dynamic login(
      {required String? loginEmail, required String? loginPassword}) async {
    Map<dynamic, dynamic> body = {
      "email": loginEmail,
      "password": loginPassword
    };
    try {
      var response = await UserServices.signin(
          body); // signin fuction returns response.body

      var data = json.decode(response);
      print(data);
      print(data["success"]);
      if (data["success"] == true) {
        token = (data["token"]);
        await MySharedPreferences.init();

        await MySharedPreferences.setTokenWithType(token, data["usertype"]);
        await MySharedPreferences.setToken(token);
        usertype = await MySharedPreferences.setUsertype(data["usertype"]);
        await MySharedPreferences.setUsertype(data["usertype"]);
        await MySharedPreferences.setLoginId(data["data"]["_id"]);
        print(token);
        return true;
      } else {
        // isLogin = false;
        return false;
      }
    } on Exception {
      print(Exception("Error in network connection"));
    }
  }

  final myEmailKey = GlobalKey<FormState>();
  final myPasswordKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  bool hidePassword = true;
  bool checkValue = false;

  // @override
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 180,
                    height: 180,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff0077B6),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: Form(
                      key:
                          _formKey, // yo form lai unique sanga chinna lai form key rakyeko ho
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email address ";
                          }
                          return null;
                        },
                        key: myEmailKey,
                        controller: emailController,
                        decoration: const InputDecoration(
                            focusColor: Colors.black,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: Form(
                      key: _formKey1,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          if (value.length <= 3) {
                            return "Password cannot be less than 3 character";
                          } else {
                            () {
                              return null;
                            };
                          }
                        },
                        key: myPasswordKey,
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: checkValue,
                        onChanged: (bool? value) {
                          print("check value is $checkValue");
                          setState(() {
                            checkValue = !checkValue;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkValue = checkValue;
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
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 120.0, vertical: 12.0)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 119, 182)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      )),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _formKey1.currentState!.validate()) {
                        dynamic Data = await login(
                            loginEmail: emailController.text,
                            loginPassword: passwordController.text);
                        print("my Data is :$Data");
                        if (Data != true) {
                          //form valid xa ki xaina check garxa
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Invalid login")));
                          }
                        } else {
                          if (checkValue) {
                            await MySharedPreferences.init();
                            await MySharedPreferences.setEmail(
                                emailController.text);
                            await MySharedPreferences.setPassword(
                                passwordController.text);
                            print("Value saved --> ${emailController.text}");
                            print("Value saved --> ${passwordController.text}");
                          }
                          Navigator.pushNamed(context, "/home");
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("please validate form first login")));
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword())),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 18, color: Color(0xff0077B6)),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Color(0xff0077B6)),
                    ),
                  ),
                )
            ]
            ),
          ),
        ),
      ),
    );
  }

  void getUserDetails() async {
    try {
      await MySharedPreferences.init();
      var email = MySharedPreferences.getEmail;
      var password = MySharedPreferences.getPassword;
      if (email != "" && password != "") {
        _loadUserEmailPassword(email, password);
      } else {
        Navigator.pushNamed(context, "/login");
      }
    } catch (err) {
      print(err);
    }
  }

  void _loadUserEmailPassword(String? loginEmail, String? loginPassword) async {
    Map<dynamic, dynamic> body = {
      "email": loginEmail,
      "password": loginPassword
    };
    try {
      var response = await UserServices.signin(body);
      var data = json.decode(response);
      if (data["success"] == true) {
        await MySharedPreferences.init();
        await MySharedPreferences.setTokenWithType(
            data["token"], data["usertype"]);
        await MySharedPreferences.setToken(data["token"]);
        await MySharedPreferences.setUsertype(data["usertype"]);
        await MySharedPreferences.setLoginId(data["data"]["_id"]);
        Navigator.pushNamed(context, "/home");
      }
    } on Exception {
      print(Exception("Error in network connection"));
    }
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
