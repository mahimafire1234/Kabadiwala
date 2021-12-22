import 'package:flutter/material.dart';

class Rates extends StatefulWidget{
  const Rates({Key ? key}) : super(key:key);

  @override
  _RatesState createState()=> _RatesState();
}

class _RatesState extends State<Rates>{
  Widget buildNavigationButton () => FloatingActionButton(
    //onclick
    onPressed: (){
      print("fab clicked");
    },
    child: Text("+",style:TextStyle(fontWeight: FontWeight.w200)),
    backgroundColor: Color(0xff0077B6),
  );

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
                    child: Text("This is my rates page",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15
                      ),
                    ),
                  )
              ),
            ],
          )
        ),
      ),
      floatingActionButton: buildNavigationButton(),
    );


  }
}