import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/company/oneCompany.dart';

class ViewCompany extends StatefulWidget {
  ViewCompany({Key? key}) : super(key: key);

  @override
  _ViewCompanyState createState() => _ViewCompanyState();
}

class _ViewCompanyState extends State<ViewCompany> {
  bool isDescending =false;
  List<User>? users = [];
  String query = ''; //words user typed
  Timer? debouncer;

  Future<List<User>?> getUserData(query) async {
    var response = await http.get(
      Uri.parse("$BASEURI/user/get_company"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    List<User> userData = [];
    for (var u in jsonData["user"]) {
      if (query != "") {
        final nameLower = u["name"].toLowerCase();
        final searchLower = query.toLowerCase();
        if (nameLower.contains(searchLower)) {
          User user = User(u["name"], u["email"],u["id"], u["phone"], u["companyLocation"], u["image"]);
          userData.add(user);
        }
      } else {
        User user = User(u["name"], u["email"],u["id"], u["phone"], u["companyLocation"], u["image"]);
        userData.add(user);
      }
    }
    return userData;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final users = await getUserData(query);

    setState(() => this.users = users);
  }

  Future searchUsers(String query) async => debounce(() async {
        final users = await getUserData(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.users = users;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Color(0xff0077B6)),
        backgroundColor: const Color(0xFF0077B6),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Card(
          color: const Color(0xFF0077B6),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Column(children: [
                    PhysicalModel(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      elevation: 10.0,
                      shadowColor: const Color(0xff000f61),
                      child: TextFormField(
                        onChanged: (val) => searchUsers(val),
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: Color(0xFF000000),
                            ),
                            labelText: "Search..",
                            contentPadding: EdgeInsets.only(left: 80.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(280, 10, 0, 0),
                      child: Ink(
                        color: Colors.orange,
                        child: IconButton(
                          icon: const Icon(Icons.sort_outlined),
                          color: Colors.white,
                          onPressed: () {
                            isDescending = !isDescending;
                              setState(() {
                                users?.sort((a, b) => isDescending ? a.name.compareTo(b.name) : b.name.compareTo(a.name) );
                              });
                            }
                        ),
                      ),
                    ),
                    users!.isEmpty
                        ? const Text("No companies found ",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: users!.length,
                            itemBuilder: (context, i) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: PhysicalModel(
                                    borderRadius: BorderRadius.circular(15),
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => oneCompany(
                                                  companyID: users![i].id),
                                              // settings: RouteSettings(
                                              //   arguments: data,
                                              // )
                                            ));
                                      },
                                      title: Row(
                                        children: [
                                          users![i].image == null || users![i].image == ""
                                              ? Text("image")
                                              : Image.network(
                                              "$BASEURI/${users![i].image}",
                                            width: 50,
                                            height: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  users![i].name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(children: [
                                                  Text(users![i].email),
                                                  const SizedBox(width: 10.0),
                                                  // Text(snapshot.data![i].id),
                                                ]),
                                                const SizedBox(height: 10.0),
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
                          ),
                  ]))
                ],
              ),
            ),
          ]),
        ))));
  }

  compareString(bool ascending, String value1, String value2) {
    ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }
}

class User{
  final String name, email,id;
  final String? companyLocation, phone, image;
  User(this.name, this.email,this.id, this.phone, this.companyLocation, this.image);
}
