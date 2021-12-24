import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
                  children: [
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
                  child: Text("Company name",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ))),
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
                    onPressed: () {},
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
                        child:new InkWell(
                          onTap: (){
                            print("hello");
                          },
                          child: Center(
                            // onPressed:(){print("clicked");},
                              child: Text("My pricings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        )
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
                        child: Center(
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
