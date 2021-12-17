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
      print(users.length);
      return users;


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          child: FutureBuilder<List<User>>(
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
                itemCount : snapshot.data?.length,
                itemBuilder : (context, i){
                  return ListTile(
                  title: Row(
                    children: [
                      Text("image"),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![i].name),
                            Row(
                              children:[
                                Text(snapshot.data![i].email),
                                Text(snapshot.data![i].number),
                              ]
                            ),
                            Text("Rating: ")
                          ],
                        ),
                      ),
                    ],
                  ),


                  );
                  },
                );
              }
            },
          ),

        )
      )

    );
  }
}

class User{
  final String name, email, number;
  User(this.name, this.email, this.number);
}
