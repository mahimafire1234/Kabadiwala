import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/company/oneCompany.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class ViewCompany extends StatefulWidget {
  List<String> sortList = <String>["Name"];

  ViewCompany({Key? key}) : super(key: key);

  Future<List<User>?> getUserData() async {
    var response = await http.get(
      Uri.parse("http://192.168.100.252:5000/user/get_company"),
      headers: {
        'Content-type': 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData["user"]) {
      User user = User(u["name"], u["email"], u["id"]);
      users.add(user);
    }
    return users;
  }

  @override
  _ViewCompanyState createState() => _ViewCompanyState();
}

class _ViewCompanyState extends State<ViewCompany> {
  String selectedValue = "Name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0077B6),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Card(
                color: const Color(0xFF0077B6),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: PhysicalModel(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              elevation: 10.0,
                              shadowColor: Color(0xff000f61),
                              child: TextField(
                                obscureText: true,
                                onChanged: (val) {},
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0)),
                                    prefixIcon: Icon(
                                      CupertinoIcons.search,
                                      color: Color(0xFF000000),
                                    ),
                                    labelText: "Search..",
                                    contentPadding:
                                        EdgeInsets.only(left: 80.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: PhysicalModel(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              elevation: 5.0,
                              shadowColor: const Color(0xff2a2a2a),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(left: 30.0)),
                                value: selectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedValue = newValue! as String;
                                    print(selectedValue);
                                  });
                                },
                                items: widget.sortList.map((String value1) {
                                  return DropdownMenuItem<String>(
                                    value: value1,
                                    child: new Text(value1),
                                  );
                                }).toList(),
                                isDense: true,
                                isExpanded: true,
                              ),
                            ),
                          ),
                          FutureBuilder<List<User>?>(
                            future: widget.getUserData(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                    child: Text("Loading.. 1"),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, i) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: PhysicalModel(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                          elevation: 10.0,
                                          shadowColor: Color(0xff000f61),
                                          child: ListTile(
                                            tileColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            onTap: () async {
                                              final data =
                                                  await widget.getUserData();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        oneCompany(
                                                            id: snapshot
                                                                .data![i].id),
                                                    // settings: RouteSettings(
                                                    //   arguments: data,
                                                    // )
                                                  ));
                                            },
                                            title: Row(
                                              children: [
                                                Text("image"),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data![i].name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      SizedBox(height: 10.0),
                                                      Row(children: [
                                                        Text(snapshot
                                                            .data![i].email),
                                                        SizedBox(width: 10.0),
                                                        // Text(snapshot.data![i].id),
                                                      ]),
                                                      SizedBox(height: 10.0)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ])),
              ),
            ),
          ),
        ));
  }
}

class User {
  final String name, email, id;

  User(this.name, this.email, this.id);
}
