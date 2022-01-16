import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:login_sprint1/services/userservices.dart';

class LoginPage extends StatefulWidget {
  String email = "";
  String password = "";
  var token;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginPage({Key? key}) : super(key: key);

  dynamic isLogin = true;

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
        await MySharedPreferences.setUsertype(data["usertype"]);
        await MySharedPreferences.setLoginId(data["data"]["_id"]);
        print(token);
        return isLogin;
      } else {
        isLogin = false;
        return isLogin;
      }
    } on Exception {
      print(Exception("Error in network connection"));
    }
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myEmailKey = GlobalKey<FormState>();
  final myPasswordKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

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
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 180,
                  height: 180,),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Center(
                  child: Form(
                    key:
                        _formKey, // yo form lai unique sanga chinna lai form key rakyeko ho
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter email address ";
                        }
                        return null;
                      },
                      key: myEmailKey,
                      controller: widget.emailController,
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
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                child: Center(
                  child: Form(
                    key: _formKey1,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter password";
                        }
                        if (value.length <= 3) {
                          return "password cannot be less than 3 character";
                        } else {
                          () {
                            return null;
                          };
                        }
                      },
                      key: myPasswordKey,
                      controller: widget.passwordController,
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
              SizedBox(
                height: 50,
                child:
                ElevatedButton(

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
                    dynamic Data = await widget.login(
                        loginEmail: widget.emailController.text,
                        loginPassword: widget.passwordController.text);

                    var loginEmail = widget.emailController.text;
                    var loginPassword = widget.passwordController.text;
                    Map<dynamic, dynamic> body = {
                      "email": loginEmail,
                      "password": loginPassword
                    };

                    var response = await UserServices.signin(
                        body); // signin fuction returns response.body
                    var data = json.decode(response);

                    print(data["data"]["usertype"]);
                    var usertype = (data["data"]["usertype"]);
                    print("my Data is :$Data");
                    print(data["data"]["userType"]);

                    if (_formKey.currentState!.validate() &&
                        _formKey1.currentState!.validate()) {
                      if (Data != true) {
                        //form valid xa ki xaina check garxa
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid login")));
                        }
                      } else {
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
