import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const oneCompany());
}

class oneCompany extends StatelessWidget {
  const oneCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ShowOne(), debugShowCheckedModeBanner: false);
  }
}

class ShowOne extends StatefulWidget {
  @override
  _ShowOneState createState() => _ShowOneState();
}

class _ShowOneState extends State<ShowOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 25,
        ),
        Center(
          child:
        Image(
          image: AssetImage("assets/company.jpg"),
          width: 200,
          height: 200,
        )
        ),
        Center(
            child: Text("Company: XYZ Company",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))),
        Center(
            child: Text("Phone Number: +977-9876543210",
                style: TextStyle(color: Colors.black, fontSize: 20))),
        Center(
            child: Text("Address: Dilibazar,Kathmandu",
                style: TextStyle(color: Colors.black, fontSize: 20))),
        Center(
          child: Row(children: [
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
        ),
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
