import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/appointment/view_appointment.dart';
import 'package:login_sprint1/pages/booking/booking_request.dart';
import 'package:login_sprint1/pages/rates/ratespage.dart';
import 'package:login_sprint1/pages/user/profile_update.dart';
import 'package:login_sprint1/services/shared_preference.dart';

import '../../services/userservices.dart';
import 'login.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  String id = "";
  String user_type = "";
  String image = "";
  String email = "";
  String phone = "";
  String location = "";

  @override
  void initState() {
    super.initState();

    getuserdata();
  }

  Future<List<String>> getuserdata() async {
    await MySharedPreferences.init();

    final token = await MySharedPreferences.getToken();
    String usertype = await MySharedPreferences.getUsertype!;

    String url;
    // print(token);
    if (usertype == "company") {
      url = "$BASEURI/user/loggedin_company";
    } else {
      url = "$BASEURI/user/loggedin_user";
    }
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
    });

    var data = await json.decode(response.body);
    // print(data);
    String user_name = await data["data"]["name"];
    String user_id = await data["data"]["_id"];
    String image = await data["data"]["image"];
    print(usertype);
    //list
    List<String> companyInfo = [user_id, user_name, usertype];
    //set variable
    setState(() {
      id = user_id;
      user_type = usertype;
      this.image = image;
      email = data["data"]["email"];
      phone = data["data"]["phone"];
      location = data["data"]["companyLocation"];
    });
    return companyInfo;
  }

  @override
  Widget build(BuildContext context) {
    if (user_type == "company") {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      this.image == "" || this.image == null
                          ? Image(
                              image: AssetImage("assets/images/cycling.png"),
                              width: 200,
                              height: 200,
                            )
                          : Image.network("$BASEURI/$image",
                              width: 200, height: 200)
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: FutureBuilder<List<String>>(
                      future: getuserdata(),
                      builder: (context, snapshot) {
                        return (snapshot.hasData == true &&
                                snapshot.data != null)
                            ? Text(snapshot.data![1],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ))
                            : Text("empty",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ));
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(this.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(this.phone != null || this.phone != "" ? this.phone : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(this.location == null || this.location == "" ? "" : this.location,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Divider(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileUpdate()));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                  "assets/icons/setting.png",
                                width: 20,
                                height: 20
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "Edit profile",

                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/paymentRequest");
                          },
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.book),
                              SizedBox(width: 5.0),
                              Text("Transactions History",
                                  textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          child: Row(
                            children: [
                              Icon(
                                  CupertinoIcons.square_arrow_left,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.red
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await MySharedPreferences.init();
                            await MySharedPreferences.removeSavedDetails();
                            Navigator.pushNamed(context, "/login");
                          },
                        )
                      ]
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      this.image == "" || this.image == null
                          ? Image(
                              image: AssetImage("assets/images/cycling.png"),
                              width: 200,
                              height: 200,
                            )
                          : Image.network("$BASEURI/$image",
                              width: 200, height: 200)
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: FutureBuilder<List<String>>(
                      future: getuserdata(),
                      builder: (context, snapshot) {
                        return (snapshot.hasData == true &&
                                snapshot.data != null)
                            ? Text(snapshot.data![1],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ))
                            : Text("empty",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ));
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(this.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(this.phone != null || this.phone != "" ? this.phone : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(this.location == null || this.location == "" ? "" : this.location,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Divider(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileUpdate()));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                    "assets/icons/setting.png",
                                    width: 20,
                                    height: 20
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "Edit profile",

                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/paymentRequest");
                            },
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.book),
                                SizedBox(width: 5.0),
                                Text("Transactions History",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            child: Row(
                              children: [
                                Icon(
                                    CupertinoIcons.square_arrow_left,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: Colors.red
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              await MySharedPreferences.init();
                              await MySharedPreferences.removeSavedDetails();
                              Navigator.pushNamed(context, "/login");
                            },
                          )
                        ]
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      );
    }
  }
}


