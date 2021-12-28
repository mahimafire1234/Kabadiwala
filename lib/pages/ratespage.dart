import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_sprint1/pages/insertrate.dart';
import 'package:login_sprint1/services/userservices.dart';

class Rates extends StatefulWidget{
  const Rates({Key ? key}) : super(key:key);

  @override
  _RatesState createState()=> _RatesState();
}

class _RatesState extends State<Rates>{
  Widget buildNavigationButton () => FloatingActionButton(
    //onclick
    onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder:(context)=> InsertRate()));
    },
    child: Text("+",style:TextStyle(fontWeight: FontWeight.w200)),
    backgroundColor: Color(0xff0077B6),
  );

  //empty varibale
  var _postsJson = [];
  //get response
  fetchData() async{
    try{
      var services = UserServices();
      var response = services.getRate("9");
      print(response);
      setState(() {
      });
      // print(response);
      return response;
    }
    catch(error){
      print(error);
    }
  }

  //call the get method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu_rounded),
            onPressed: () {},
          ),
          title: Center(child: Text("Kabadiwala")),
          backgroundColor: Color(0xff0077B6)),
      body:SafeArea(
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Center(
                 child: Padding(
                    padding: EdgeInsets.all(10.0),

                    ),
              )
            ],
          )
        ),
      ),
      floatingActionButton: buildNavigationButton(),
    );


  }
}