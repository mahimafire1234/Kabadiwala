import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/company/viewcompany.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:login_sprint1/services/userservices.dart';
import 'dart:io';

import 'change_password.dart';
import 'login.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  String image = "";
  String imageFrom = "asset";

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

  Future pickImage(ImageSource source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return ;

      final temporaryImage = File(image.path);
      setState(() {
        this.imageFrom = "phone";
        this.image = temporaryImage.path;
      });
    }on PlatformException catch(e){
      print(e);
    }

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
        print(u["image"]);

        if(u["image"] != null || u["image"] != ""){
          setState(() {
              image = u["image"];
              imageFrom ="api";
          });
        }

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Profile"),
      ),
       body: SafeArea(
         child: SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.all(12.0),
             child: Form(
               key: _key,
                 child: Column(
                   children: [
                     ProfileWidget(
                       imagePath: image,
                       imageFrom: imageFrom,
                       isEdit: true,
                       onClicked: () async {
                         showModalBottomSheet(
                             context: context,
                             builder: (context) => Column(
                               mainAxisSize: MainAxisSize.min,
                               children:[
                                 ListTile(
                                   leading: Icon(Icons.camera_alt),
                                   title: Text('Camera'),
                                   onTap: () => pickImage(ImageSource.camera),
                                 ),
                                 ListTile(
                                   leading: Icon(Icons.image),
                                   title: Text('Gallery'),
                                   onTap: () => pickImage(ImageSource.gallery),
                                 )
                               ]
                             ));
                       },
                     ),
                     SizedBox(height: 10.0),
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
                       controller: _phoneController,
                       obscureText: false,
                     ),
                     InputField(
                       labelText: "Location",
                       emptyValidationText: "Enter location",
                       prefixIcon: CupertinoIcons.location,
                       controller: _locationController,
                       obscureText: false,
                     ),
                     const SizedBox(height: 20.0),
                     Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ElevatedButton(
                               onPressed: () {
                                 Navigator.pop(context);
                               },
                               child: Text("Cancel"),
                               style: ElevatedButton.styleFrom(
                                 primary: Color(0xFFFFFFFF),
                                 onPrimary: Color(0xFF0077B6),
                               )
                           ),
                           const SizedBox(width: 10.0),
                           ElevatedButton(onPressed: () async {

                             var body = {
                               "name": _nameController.text,
                               "email": _emailController.text,
                               "phone": _phoneController.text,
                               "companyLocation": _locationController.text,
                             };

                             var token = MySharedPreferences.getToken();
                             var response = await UserServices.update(token, image, body, imageFrom);
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
                               Navigator.pop(context);
                             }
                           },
                             child: const Text("Update Profile")),

                         ]
                     ),
                     SizedBox(height: 10.0),
                     Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(
                               onPressed: () {
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context) => ChangePassword()));
                               },
                               child: Text("Change Password"))
                         ]
                     ),
                     Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(
                               onPressed: () {
                                 showAlertDialog(context);
                                 },
                               child: Text(
                                   "Delete Account",
                                 style: TextStyle(color: Colors.red),
                               ))
                         ]
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
  Function? validator;
  TextInputType? keyboardType;
  TextEditingController controller;
  bool? obscureText;

  InputField({Key? key,
    required this.labelText,
    required this.emptyValidationText,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
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
        validator: (value) => validator!(value),
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


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final String imageFrom;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.imageFrom,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    if(imageFrom == "api") print("from api");
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: imagePath == "" || imagePath == null ? Image.asset("assets/images/cycling.png", width: 128, height: 128) : (
            imageFrom == "phone"? Image.file(File(imagePath), width: 128, height: 128) :
            Image.network("$BASEURI/$imagePath", width: 128, height: 128,
              loadingBuilder: (context, child, loadingProgress){
                if(loadingProgress == null){
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded/int.parse(loadingProgress.expectedTotalBytes.toString()) :
                        null,
                  )
                );
              },

            )
        )
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 1,
      child: IconButton(
        onPressed: onClicked,
        icon: Icon(
          isEdit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () async {
        Navigator.of(context).pop(true);
      });
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () async {
      var id = MySharedPreferences.getLoginId!;
      print(id);
      var response = await UserServices.deleteAccount(id);
      print("response -----> $response");
      var resBody = json.decode(response!);
      print("resBody -----> $resBody");

      if (resBody["success"] == true) {
        final snackB = SnackBar(
          duration: Duration(seconds: 3),
          content: Text(resBody["message"]),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackB);
        print("true");
        await MySharedPreferences.init();
        await MySharedPreferences.removeSavedDetails();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        final snackB = SnackBar(
          duration: Duration(seconds: 5),
          content: Text(resBody["message"]),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackB);
        Navigator.of(context).pop(true);
      }
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    elevation: 10,
    title: Text("Alert"),
    content: Text("Are your sure you want to delete account?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}