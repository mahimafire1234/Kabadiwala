import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sprint1/pages/user/profile_update.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:login_sprint1/services/userservices.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool hideNewConfirmPassword = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  var _oldPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _newPasswordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Update Profile")
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Text("Change Password",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20),
                  InputField(
                    labelText: "Old Password",
                    emptyValidationText: "Enter old password",
                    prefixIcon: CupertinoIcons.lock,
                    controller: _oldPasswordController,
                    validator: (value) => value.isEmpty ? "Please enter password": null,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          hideOldPassword = !hideOldPassword;
                        });
                      },
                      child: hideOldPassword == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    obscureText: hideOldPassword,
                  ),
                  InputField(
                    labelText: "New Password",
                    emptyValidationText: "Enter new password",
                    prefixIcon: CupertinoIcons.lock,
                    validator: (value) => value.isEmpty ? "Please enter password": null,
                    controller: _newPasswordController,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          hideNewPassword = !hideNewPassword;
                        });
                      },
                      child: hideNewPassword == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    obscureText: hideNewPassword,
                  ),
                  InputField(
                    labelText: "Confirm New Password",
                    emptyValidationText: "Enter new password again",
                    validator: (String? value) {
                      if (value != _newPasswordController.value.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    prefixIcon: CupertinoIcons.lock,
                    controller: _newPasswordConfirmController,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          hideNewConfirmPassword = !hideNewConfirmPassword;
                        });
                      },
                      child: hideNewConfirmPassword == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    obscureText: hideNewConfirmPassword,
                  ),
                  ElevatedButton(onPressed: () async {
                    if (_key.currentState!.validate()){
                      var body = {
                        "password": _oldPasswordController.text,
                        "newPassword": _newPasswordController.text
                      };

                      var token = MySharedPreferences.getToken();
                      var response = await UserServices.changePassword(token, body);
                      var resBody = json.decode(response!);
                      print(resBody);

                      final snackB = SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text(resBody["message"]),
                        action: SnackBarAction(
                          label: 'Dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackB);
                      if(resBody["success"]){
                        Navigator.pop(context);
                      }
                    }
                  }, child: Text("Change Password"))
                ]
              ),
            ),

          )
        )
      )
    );
  }
}
