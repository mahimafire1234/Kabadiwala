import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:login_sprint1/pages/ratespage.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  String id ="";
  Future<List<String>> getuserdata() async {
    await MySharedPreferences.init();

    final token = await MySharedPreferences.getToken();
    // print(token);
    var response = await http
        .get(Uri.parse("http://10.0.2.2:5000/user/loggedin_company"), headers: {
      "Authorization": "Bearer $token",
    });

    var data = await jsonDecode(response.body);
    print(data);
    String company_name = await data["data"]["name"];
    String company_id = await data["data"]["_id"];
    //list
    List<String> companyInfo = [company_id,company_name];
    //set variable
    setState(() {
      id = company_id;
    });
    return companyInfo;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage("assets/images/cycling.png"),
                      width: 200,
                      height: 200,
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: FutureBuilder<List<String>>(
                    future: getuserdata(),
                    builder: (context, snapshot) {
                      return (snapshot.hasData == true && snapshot.data != null)
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
                              )
                      );
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
                      // getuserdata();
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Rates(company_id: id)));
                            print("id"+id);
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
