import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/shared_preference.dart';
import 'notifications/reminder.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  getSchedule() async{

    await MySharedPreferences.init();
    final token = await MySharedPreferences.getToken();

    var res =  await http.get(Uri.parse("http://10.0.2.2:5000/booking/reminder"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var jsonData = await json.decode(res.body);
    print(jsonData);
    for(int i = 0; i<jsonData["result"].length; i++){

      var year = jsonData["result"][i]["datetime"].toString().substring(0, 4);
      var month = jsonData["result"][i]["datetime"].toString().substring(5, 7);
      var day = jsonData["result"][i]["datetime"].toString().substring(8, 10);
      var hour = jsonData["result"][i]["datetime"].toString().substring(11, 13);
      var minute = jsonData["result"][i]["datetime"].toString().substring(14, 16);


      NotificationWeekAndTime pickedSchedule = NotificationWeekAndTime(
          year: int.parse(year),
          month: int.parse(month),
          day: int.parse(day),
          hour: int.parse(hour),
          minute: int.parse(minute));
      reminder(pickedSchedule);

    }


  }

  @override
  void initState() {  //for notification permission
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {   //if notification permission not allowed show this pop up
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('Our app would like to send you notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); //when pressed the option close the popup
                      },
                      child: const Text(
                        'Don\'t Allow',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()  //shows settings ko permission
                              .then((_) => Navigator.pop(context)), // close popup
                      child: const Text(
                        'Allow',
                        style: TextStyle(
                          color:  Color(0xFF0077B6),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
          );
        }
      },
    );

  }


  @override
  Widget build(BuildContext context) {
    getSchedule();

    // NotificationWeekAndTime pickedSchedule = NotificationWeekAndTime(day: 3, hour: 11, minute: 48);
    //
    // reminder(pickedSchedule);
    // widget.getSchedule();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Scoreboard",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontFamily: 'Rubik')),
                      Text("This week",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 182, 18),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Rubik')),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Text("41",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 214, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            SizedBox(height: 5.0),
                            Text("Highest",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                          ]),
                          Column(children: [
                            Text("29",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 172, 47),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                            Text("Your points",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                          ]),
                          Column(children: const [
                            Text("10",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 235, 11, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text("Average",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                          ]),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(25.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(100, 240, 240, 240),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              )),
                          child: GridView.count(
                            shrinkWrap: true,
                            childAspectRatio: 2.0,
                            crossAxisCount: 2,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    )),
                                child: const Option(
                                    image: "assets/icons/garbage-truck.png",
                                    text: "Order a \n pickup",
                                    link: "/orderpickup"),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 20.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                        left: BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      )),
                                  child: Option(
                                      image: "assets/icons/list.png",
                                      text: "Scoreboard")),
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    )),
                                child: Option(image: "assets/icons/delivery.png",
                                    text: "Vendors",
                                    link: "/viewcompany"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      left: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    )),
                                child:  Option(image: "assets/icons/group.png", text: "Forum"),
                              )
                            ],
                          )),
                    ],
                  ),
                )
            ))

    );
  }
}

class Option extends StatefulWidget {
  final String? image;
  final String? text;
  final String? link;

  const Option({Key? key, this.image, this.text, this.link}) : super(key: key);

  @override
  _OptionState createState() =>
      _OptionState(image: this.image, text: this.text, link: this.link);
}

class _OptionState extends State<Option> {
  String? image;
  String? text;
  String? link;

  _OptionState({this.image, this.text, this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {Navigator.pushNamed(context, link.toString());},
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("${image}", width: 50),
            SizedBox(width: 15.0),
            Text("${text}", overflow: TextOverflow.fade)
          ]),
    );
  }
}