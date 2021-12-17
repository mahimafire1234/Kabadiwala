import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewCompany extends StatefulWidget {
  const ViewCompany({Key? key}) : super(key: key);

  @override
  _ViewCompanyState createState() => _ViewCompanyState();
}

class _ViewCompanyState extends State<ViewCompany> {
    Future<List<User>>? getUserData() async{
      var response = await http.get(Uri.parse("http://10.0.2.2:5000/user/get_company"));
      var jsonData = await jsonDecode(response.body);
      List<User>users = [];
      for(var u in jsonData["user"]){
        User user = User(u["name"], u["email"], u["phone"]);
        users.add(user);
      }

      return users;


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0077B6),
        body: SafeArea(
          child: Container(
          child: Card(
            color: const Color(0xFF0077B6),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20
                        ),
                        child: PhysicalModel(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          elevation: 10.0,
                          shadowColor: Color(0xff000f61),
                          child: TextField(
                            obscureText: true,
                            onChanged: (val) {
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                    BorderSide(color: Colors.black,  width: 2.0)),
                                prefixIcon: Icon(
                                  CupertinoIcons.search,
                                  color: Color(0xFF000000),
                                ),
                                labelText: "Search..",
                                contentPadding: EdgeInsets.only(left: 80.0)),
                          ),
                        ),
                      ),
                      FutureBuilder<List<User>>(
                        future:    getUserData() ,
                        builder:  (context,  snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text("Loading.. 1"),
                              ),
                            );
                          }else {
                            return ListView.builder(
                              shrinkWrap: true,
                            itemCount : snapshot.data?.length,
                            itemBuilder : (context, i){
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: PhysicalModel(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  elevation: 10.0,
                                  shadowColor: Color(0xff000f61),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  title: Row(
                                    children: [
                                      Text("image"),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![i].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),

                                            SizedBox(height: 10.0),
                                            Row(
                                              children:[
                                                Text(snapshot.data![i].email),
                                                SizedBox(width: 10.0),
                                                Text(snapshot.data![i].number),
                                              ]
                                            ),
                                            SizedBox(height: 10.0),
                                            Text("Rating: "),

                                          ],
                                        ),
                                      ),
                                    ],
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
                ],
              ),
            ),

          )
      ),
        )

    );
  }
}

class User{
  final String name, email, number;
  User(this.name, this.email, this.number);
}

// TextField(
// obscureText: true,
// onChanged: (val) {
// },
// decoration: InputDecoration(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.all(Radius.circular(20)),
// borderSide:
// BorderSide(color: Colors.black, width: 2.0)),
// prefixIcon: Icon(
// CupertinoIcons.search,
// color: Color(0xFF000000),
// ),
// labelText: "Search",
// contentPadding: EdgeInsets.only(left: 80.0)),
// ),
