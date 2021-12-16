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
    getUserData() async{
      var response = await http.get(Uri.parse("http://10.0.2.2:5000/user/get_company"));
      var jsonData = jsonDecode(response.body);
      List<User>users = [];
      for(var u in jsonData){
        User user = User(u["name"], u["email"], u["number"]);
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
          child: FutureBuilder(
            future: getUserData(),
            builder: (context,snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading.."),
                  ),
                );
              }else
                return ListView.builder(
                itemCount : snapshot.data!.length,
                itemBuilder : (context, i){
                  return ListTile(
                  title: Text(snapshot.data[i].name),
                  subtitle: Text(snapshot.data[i].email),
                  trailing: Text(snapshot.data[i].number),

                  );
                  },
                );
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
