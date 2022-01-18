import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/company/viewcompany.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:login_sprint1/services/userservices.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  User? user = null ;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  @override
  void initState() {
    getUserData();


    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _locationController = TextEditingController();
  }

  Future<Object?> getUserData() async {
    try{
      MySharedPreferences.init();
      var token = MySharedPreferences.getToken();

      var response = await UserServices.getUserData(token);
      var resBody = json.decode(response!);

      if(resBody["success"]){
        var u = resBody["data"];

        _nameController.text = u["name"];
        _emailController.text = u["email"];
        _phoneController.text = u["phone"];
        _locationController.text = u["companyLocation"];

        return resBody["data"].toString();
      }
      return "";
    }catch(err){
      print(err);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.all(12.0),
             child: Form(
               key: _key,
                 child: Column(
                   children: [
                     InputField(
                       labelText: "Name",
                         emptyValidationText: "Enter name",
                         prefixIcon: CupertinoIcons.profile_circled,
                         validator: (value) =>  value!.isEmpty ? "Please enter username" : null,
                        controller: _nameController,
                       obscureText: false,
                     ),
                     InputField(
                       labelText: "Email",
                       emptyValidationText: "Enter email",
                       keyboardType: TextInputType.emailAddress,
                       prefixIcon: CupertinoIcons.envelope,
                       validator: (value) =>  value!.isEmpty ? "Please enter email" : null,
                       controller: _emailController,
                       obscureText: false,
                     ),
                     InputField(
                       labelText: "Phone",
                       emptyValidationText: "Enter phone number",
                       keyboardType: TextInputType.number,
                       prefixIcon: CupertinoIcons.rectangle_stack_person_crop,
                       validator: (value) =>  value!.isEmpty ? "Please enter phone number" : null,
                       controller: _phoneController,
                       obscureText: false,
                     ),
                     InputField(
                       labelText: "Location",
                       emptyValidationText: "Enter location",
                       prefixIcon: CupertinoIcons.location,
                       validator: (value) =>  value!.isEmpty ? "Please enter phone number" : null,
                       controller: _locationController,
                       obscureText: false,
                     )
                   ]
                 )),
           ),
         )
       ),
    );
  }
}

class InputField extends StatelessWidget {
  String labelText;
  String emptyValidationText;
  IconData prefixIcon;
  Widget? suffixIcon;
  Function validator;
  TextInputType? keyboardType;
  TextEditingController controller;
  bool? obscureText;

  InputField({Key? key,
    required this.labelText,
    required this.emptyValidationText,
    required this.prefixIcon,
    this.suffixIcon,
    required this.validator,
    this.keyboardType,
    required this.controller,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText!,
        validator: (val) => validator(val),
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black, width: 2.0)),
            prefixIcon: Icon( prefixIcon, color: const Color(0xFF000000)),
            suffixIcon: suffixIcon,
            labelText: labelText,
            contentPadding: const EdgeInsets.only(left: 10.0)),
      ),
    );
  }
}

