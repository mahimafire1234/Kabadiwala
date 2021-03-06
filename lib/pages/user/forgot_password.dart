import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sprint1/pages/user/profile_update.dart';
import 'package:login_sprint1/services/userservices.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

// To enter email address
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Center(
                  child: const Text(
                      "Forgot Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text(
                        "Enter the email address of the account \nWe will send a OTP code",
                        style: TextStyle(
                            fontSize: 14
                        ),
                ),
                     ],
                   ),
                 ),
                InputField(
                    labelText: "Email address",
                    emptyValidationText: "Enter email address",
                    prefixIcon: CupertinoIcons.envelope,
                    controller: _emailController,
                    obscureText: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            var body = {
                              "email":  _emailController.text
                            };
                            var response = await UserServices.forgotPassword(body);
                            var resBody = json.decode(response!);
                            if(resBody["success"]){
                              var email = _emailController.text;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpCode(email: email)));
                            }
                            final snackB = SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text(resBody["message"]),
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackB);
                          },
                          child: Text("Send code")
                      ),
                      SizedBox(width: 10.0),
                      ElevatedButton(
                          onPressed: ()  {
                           Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFFFFFF),
                              onPrimary: Color(0xFF0077B6),
                            )
                          ,
                          child: Text("Cancel")
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}

// check otp code
class OtpCode extends StatefulWidget {
  final email;
  const OtpCode({Key? key, required this.email}) : super(key: key);

  @override
  _OtpCodeState createState() => _OtpCodeState(email: this.email);
}

class _OtpCodeState extends State<OtpCode> {
  var email;

  _OtpCodeState({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                SizedBox(height: 40.0,),
                Text("Enter OTP code sent to email"),
                Text("Otp will expire in 5 minutes"),
                const SizedBox(height: 50),
                PinEntryTextField(
                  showFieldAsBox: true,
                  fields: 4,
                  onSubmit: (String pin) async {
                    print("submitted");
                    var body = {
                      "email": email,
                      "code": pin
                    };
                    var response = await UserServices.checkOtp(body);
                    var res = json.decode(response!);
                    if(res["success"]){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword(email: email)));
                    }
                    final snackB = SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(res["message"]),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackB);

                  },
                ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Did not get the code? "),
                      TextButton(
                          onPressed: () async {
                            var body = {
                              "email":  email
                            };
                            var response = await UserServices.forgotPassword(body);
                            var resBody = json.decode(response!);
                            final snackB = SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text(resBody["message"]),
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackB);
                          },
                        child: Text("Resend code")
                      )

                    ]
                  ),
                  ElevatedButton(
                      onPressed: ()  {
                        Navigator.popUntil(context, ModalRoute.withName("/login"));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFFFFF),
                        onPrimary: Color(0xFF0077B6),
                      )
                      ,
                      child: Text("Cancel")
                  ),
              ]
            ),
          )
        )
      ),
    );
  }
}

// reset password
class ResetPassword extends StatefulWidget {
  final email;
  const ResetPassword({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState(email: this.email);
}

class _ResetPasswordState extends State<ResetPassword> {
  var email;

  bool hideNewPassword = true;
  bool hideNewConfirmPassword = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  _ResetPasswordState({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
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
              SizedBox(height: 20.0),
              ElevatedButton(onPressed: () async {
                if (_key.currentState!.validate()){
                  var body = {
                    "email": email,
                    "password": _newPasswordController.text
                  };

                  var response = await UserServices.resetPassword( body);
                  var resBody = json.decode(response!);

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
                    Navigator.popAndPushNamed(context, "/login");
                  }
                }
              }, child: Text("Reset Password"),)
                ],
              ),
            ),

          )
        )
      )
    );
  }
}



