import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class oneCompany extends StatefulWidget {
  const oneCompany({Key? key}) : super(key: key);

  @override
  _ShowOneState createState() => _ShowOneState();
}

class _ShowOneState extends State<oneCompany> {
  // getOneCompany() async {
  //
  //   var response = await http.get(Uri.parse("http://127.0.0.1:5000/user/showOne"),
  //     headers: {
  //       'Content-type' : 'application/json',
  //       "Accept": "application/json",
  //     },
  //   );
  //   var jsonData = await jsonDecode(response.body);
  //   // for(var u in jsonData["user"]){
  //   //   User user = User(u["name"], u["email"], u["phone"]);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    final Object? company=ModalRoute.of(context)?.settings.arguments;
    print(company);

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 25,
        ),
        Center(
          child: Image.asset("company.jpg", height: 150, width: 150),
        ),
        Center(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Company: XYZ ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)))),
        Center(
            child: Text("Phone Number: +977-9876543210",
                style: TextStyle(color: Colors.black, fontSize: 20))),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 60.0, vertical: 19.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)))),
              onPressed: () {},
              child: Text(
                "Book",
              )),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black)))),
            onPressed: () {},
            child: Icon(
              CupertinoIcons.heart,
            ),
          ),
        ]),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 80.0, vertical: 19.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black)))),
          onPressed: () {},
          child: Text(
            "See Pricings",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.orange, width: 2.0)),
                  prefixIcon: Icon(
                    CupertinoIcons.checkmark_alt,
                    color: Color(0xFF000000),
                  ),
                  labelText: "Write a Review...",
                  contentPadding: EdgeInsets.only(left: 80.0)),
            ),
          ),
        ),
      ]),
    );
  }
}
// class User{
//   final String name, email, number;
//   User(this.name, this.email, this.number);
// }
