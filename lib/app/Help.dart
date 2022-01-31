import 'package:flutter/material.dart';

class Help extends StatefulWidget{
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help>{

  //help
  List<HelpItem> items = <HelpItem>[
    HelpItem(
        false, // isExpanded ?
        'How to hire a Kabadiwala?', // header
        Padding(
            padding: EdgeInsets.symmetric(vertical:5.0,horizontal: 30.0),
            child: ListTile(
              leading: Icon(Icons.message_rounded,color: Colors.green,),
              title:  Text(
                "You go to to the vendors list. Click on the particular vendor. Click on the Book Now button and fill in the details",
                textAlign: TextAlign.left,
                style:  TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              dense:true,
            )
        ), // body
        Icon(Icons.image) // iconPic
    ),
    HelpItem(
        false, // isExpanded ?
        'How to order a pickup a Kabadiwala?', // header
        Padding(
            padding: EdgeInsets.symmetric(vertical:5.0,horizontal: 30.0),
            child: ListTile(
              leading: Icon(Icons.message_rounded,color: Colors.green,),
              title:  Text(
                "You go to to the order a pick up and fill in the details",
                textAlign: TextAlign.left,
                style:  TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              dense:true,
            )
        ), // body
        Icon(Icons.image) // iconPic
    ),
    HelpItem(
        false, // isExpanded ?
        'How to add company to Favorites?', // header
        Padding(
            padding: EdgeInsets.symmetric(vertical:5.0,horizontal: 30.0),
            child: ListTile(
              leading: Icon(Icons.message_rounded,color: Colors.green,),
              title:  Text(
                "Go to the company profile page. Click on the heart icon",
                textAlign: TextAlign.left,
                style:  TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              dense:true,
            )
        ), // body
        Icon(Icons.image) // iconPic
    ),
    HelpItem(
        false, // isExpanded ?
        'How to edit appointments?', // header
        Padding(
            padding: EdgeInsets.symmetric(vertical:5.0,horizontal: 30.0),
            child: ListTile(
              leading: Icon(Icons.message_rounded,color: Colors.green,),
              title:  Text(
                "Go to the my profile.In my profile click on my appointments. Check your appointments click on the Edit button.",
                textAlign: TextAlign.left,
                style:  TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              dense:true,
            )
        ), // body
        Icon(Icons.image) // iconPic
    ),

  ];

  late ListView List_Criteria;

  @override
  Widget build(BuildContext context) {

    ListView List_Criteria= ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: ExpansionPanelList(
              elevation: 4,
              dividerColor: Colors.black,
              expandedHeaderPadding: EdgeInsets.all(10),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });},
              children: items.map((HelpItem item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return  Container(
                        margin: EdgeInsets.all(10),
                        padding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        child:ListTile(
                          leading: Icon(Icons.message_rounded,color: Colors.amberAccent,),
                          title:  Text(
                            item.question,
                            textAlign: TextAlign.left,
                            style:  TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                          dense:true,
                        )
                    );
                  },
                  isExpanded: item.isExpanded,
                  body: item.answer,
                );
              }).toList(),
            ),
          ),
        )

      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0077B6),
        appBar: AppBar(
            title: Text("Kabadiwala"),
            backgroundColor: Color(0xff0077B6)),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child:Text("Help",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:30),textAlign: TextAlign.center,),
              ),
              Expanded(
                child: List_Criteria,
              )
            ],
          ),
      )
    );

  }
}

class HelpItem{
  late bool isExpanded;
  late final String question;
  late final Widget answer;
  late final Icon iconpic;
  HelpItem(this.isExpanded, this.question, this.answer, this.iconpic);
}