import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/appointment/view_appointment.dart';
import 'package:login_sprint1/pages/booking/booking_request.dart';
import 'package:login_sprint1/pages/rates/ratespage.dart';
import 'package:login_sprint1/pages/user/profile_update.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  String id = "";
  String user_type = "";
  String image = "";
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

    var data = await jsonDecode(response.body);
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
                    children:  [
                      this.image == "" ? Image(
                        image: AssetImage("assets/images/cycling.png"),
                        width: 200,
                        height: 200,
                      ): Image.network("$BASEURI/$image")
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
                    child: Text("Address name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: Text(
                        "Edit profile",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdate()));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff0077B6)),
                        fixedSize: MaterialStateProperty.all(Size(240.0, 50.0)),
                      ),
                    )),
                SizedBox(
                  height: 400,
                  child: GridView(
                    padding: EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      Card(
                        semanticContainer: true,
                        color: Color(0xff92CAE8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                                color: Color(0xff0077B6), width: 4.0)),
                        elevation: 5,
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Rates(company_id: id)));
                            print("id" + id);
                          },
                          child: Center(
                              // onPressed:(){print("clicked");},
                              child: Text("My pricings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                      Card(
                          color: Color(0xff92CAE8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Color(0xff0077B6), width: 4.0)),
                          elevation: 5,
                          child: Center(
                              child: Text("Transactions History",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      Card(
                        color: Color(0xff92CAE8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                                color: Color(0xff0077B6), width: 4.0)),
                        elevation: 5,
                        child: new InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingRequest()));
                            },
                            child: Center(
                                child: Text("Booking requests",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))),
                      ),
                      Card(
                          color: Color(0xff92CAE8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Color(0xff0077B6), width: 4.0)),
                          elevation: 5,
                          child: const Center(
                              child: Text("My Schedule",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  ),
                )
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
                      this.image == "" ? Image(
                        image: AssetImage("assets/images/cycling.png"),
                        width: 200,
                        height: 200,
                      ): Image.network("$BASEURI/$image")
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
                    child: Text("Address name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ))),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: Text(
                        "Edit profile",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdate()));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff0077B6)),
                        fixedSize: MaterialStateProperty.all(Size(240.0, 50.0)),
                      ),
                    )),
                SizedBox(
                  height: 400,
                  child: GridView(
                    padding: EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      Card(
                        semanticContainer: true,
                        color: Color(0xff92CAE8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                                color: Color(0xff0077B6), width: 4.0)),
                        elevation: 5,
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewAppointment()));
                          },
                          child: Center(
                              // onPressed:(){print("clicked");},
                              child: Text("My appointments",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/paymentRequest");
                        },
                        child: Card(
                            color: Color(0xff92CAE8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: Color(0xff0077B6), width: 4.0)),
                            elevation: 5,
                            child: Center(
                                child: Text("Transactions History",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))),
                      ),
                      Card(
                          color: Color(0xff92CAE8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Color(0xff0077B6), width: 4.0)),
                          elevation: 5,
                          child: Center(
                              child: Text("My Favorites",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      Card(
                          color: Color(0xff92CAE8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Color(0xff0077B6), width: 4.0)),
                          elevation: 5,
                          child: const Center(
                              child: Text("My Schedule",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
