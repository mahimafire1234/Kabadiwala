import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyProfile()
    );
  }
}

//my profile widget
class MyProfile extends StatefulWidget{
  @override
  MyProfileState createState()=> MyProfileState();
}

class MyProfileState extends State<MyProfile>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu_rounded), onPressed: () {  },
          ),
          title: Text("Kabadiwala"),
          backgroundColor: Color(0xff0077B6)),
      body: Column(
        children: <Widget>[
          //container for company image
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Image(
                    image: NetworkImage("data:image/jpeg;base64,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"),
                )
                ],
            ),
          ),
      //    container for company name,address
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Company Name")
              ],
            ),
          ),

      //    container for address
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Address")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBar()
              ],
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text("Edit profile"),
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff0077B6)),
                fixedSize: MaterialStateProperty.all(Size(240.0,50.0))
              ),
            ),

          ),
      //gridview
          Container(
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing:5.0,
                mainAxisSpacing: 5.0,
                padding: EdgeInsets.all(10.0),
            ),
          )
      ]
        ,
      )
    );
  }
}
