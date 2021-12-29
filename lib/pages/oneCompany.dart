import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/priceview.dart';

class oneCompany extends StatefulWidget {
  String id;
  oneCompany({required this.id});
  // const oneCompany({Key? key}) : super(key: key);

  @override
  _ShowOneState createState() => _ShowOneState(id);
}

class _ShowOneState extends State<oneCompany> {
  String id;
  _ShowOneState(this.id);
  //get wala for one company info

  Future<List<OneCompany>>? getOneCompany() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:5000/user/showOne/${id}"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    var deriveData = jsonData["user"];
    List<OneCompany> onecompanyList =[];
    OneCompany onecompany = OneCompany(deriveData["name"], deriveData["email"], deriveData["id"]);
    onecompanyList.add(onecompany);
    // // adding data to empty list
    return onecompanyList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 35,
            ),
            Center(
              child: Image(
                image: AssetImage("assets/images/cycling.png"),
                width: 200,
                height: 200,
              ),
            ),
            FutureBuilder<List<OneCompany>>(
              future: getOneCompany() ,
              builder:  (context,  snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("empty"),
                    ),
                  );
                }else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(snapshot.data![0].name,style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                        ),
                        Container(
                          child: Text(snapshot.data![0].email,style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20)),
                        )

                      ],
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 119, 182)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 60.0, vertical: 19.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 0, 119, 182))))),
                    onPressed: () {},
                    child: Text(
                      "Book Now",
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 119, 182)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 0, 119, 182))))),
                    onPressed: () {},
                    child: Icon(
                      CupertinoIcons.heart_solid,
                      color: Colors.red,
                    ),
                  ),
                ),
              ]),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 0, 119, 182)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 118.0, vertical: 19.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Color.fromARGB(255, 0, 119, 182))))),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PriceView(company_id: id,)));
              },
              child: Text(
                "See Pricings",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.orange, width: 2.0)),
                      prefixIcon: Icon(
                        CupertinoIcons.square_pencil,
                      ),
                      suffixIcon: Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.green,
                        size: 35.0,
                      ),
                      labelText: "Write a Review...",
                      contentPadding: EdgeInsets.only(left: 80.0)),
                ),
              ),
            ),
          ]),
        ));
  }
}
class OneCompany{
  final String name, email,id;
  OneCompany(this.name, this.email,this.id);
}
