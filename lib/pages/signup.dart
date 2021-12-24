import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/userservices.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String name = "";
  String email = "";
  String number = "";
  String type = "normal";
  String password = "";
  String confirmPassword = "";

  postData() async {
    try {
      var body = {
        "name": name,
        "email": email,
        "number": number,
        "type": type,
        "password": password
      };

      var userServices = UserServices();
      var response = await userServices.signup(body);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _key,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('SIGN UP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        fontFamily: 'Rubik')),
                SizedBox(height:20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                  child: Text(
                    'User Type:',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 12, 5),
                    child: Row(children: [
                      Radio(
                          autofocus: true,
                          value: "company",
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          }),
                      Text("Company"),
                      Radio(
                          autofocus: true,
                          value: "normal",
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          }),
                      Text("Normal User"),
                    ])),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter username";
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        prefixIcon: Icon(
                          CupertinoIcons.profile_circled,
                          color: Color(0xFF000000),
                        ),
                        labelText: "Enter Name",
                        contentPadding: EdgeInsets.only(left: 10.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter email";
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                          prefixIcon: Icon(
                            CupertinoIcons.envelope,
                            color: Color(0xFF000000),
                          ),
                          labelText: "Enter email",
                          contentPadding: EdgeInsets.only(left: 10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter number";
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => number = val);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                          prefixIcon: Icon(
                            CupertinoIcons.rectangle_stack_person_crop,
                            color: Color(0xFF000000),
                          ),
                          labelText: "Enter number",
                          contentPadding: EdgeInsets.only(left: 10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter password";
                        return null;
                      },
                      obscureText: hidePassword,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
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
                              });
                            },
                            child: hidePassword == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          labelText: "Enter Password",
                          contentPadding: EdgeInsets.only(left: 10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: hideConfirmPassword,
                      validator: (String? value) {
                        if (value != _passwordController.value.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
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
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                            child: hideConfirmPassword == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          labelText: "Confirm Password",
                          contentPadding: EdgeInsets.only(left: 10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          var response = await postData();
                          var res = json.decode(response);
                          final snackB = SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text(res["message"]),
                            action: SnackBarAction(
                              label: 'Dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackB);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("SIGN UP", style: TextStyle(
                          fontSize: 18,
                        ),),
                      ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                          255, 0, 119, 182)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)
                          )
                      )
                    )

                  ),
                )
              ]),
        ),
      ),
    )));
  }
}
