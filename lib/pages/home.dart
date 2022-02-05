import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/rates/ratespage.dart';
import 'package:login_sprint1/services/shared_preference.dart';

import 'notifications/reminder.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getSchedule() async {
    final token = await MySharedPreferences.getToken();

    var res = await http.get(
      Uri.parse("$BASEURI/booking/reminder"),
      headers: {
        'Content-type': 'application/json',
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var jsonData = await json.decode(res.body);
    print(jsonData);
    if (jsonData["message"] != "Unauthorizedd") {
      for (int i = 0; i < jsonData["result"].length; i++) {
        var year = jsonData["result"][i]["datetime"].toString().substring(0, 4);
        var month =
            jsonData["result"][i]["datetime"].toString().substring(5, 7);
        var day = jsonData["result"][i]["datetime"].toString().substring(8, 10);
        var hour =
            jsonData["result"][i]["datetime"].toString().substring(11, 13);
        var minute =
            jsonData["result"][i]["datetime"].toString().substring(14, 16);

        NotificationWeekAndTime pickedSchedule = NotificationWeekAndTime(
            year: int.parse(year),
            month: int.parse(month),
            day: int.parse(day),
            hour: int.parse(hour),
            minute: int.parse(minute));

        NotificationWeekAndTime pickedScheduleHourBefore =
            NotificationWeekAndTime(
                year: int.parse(year),
                month: int.parse(month),
                day: int.parse(day),
                hour: int.parse(hour) - 1,
                minute: int.parse(minute));

        reminder(
            pickedSchedule, "Pickup time!", "Your pickup order time has come");
        reminder(pickedScheduleHourBefore, "Pickup time arriving soon",
            "Your pickup order's time is in 1 hour");
      }
    }
  }

  @override
  void initState() {
    //for notification permission
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          //if notification permission not allowed show this pop up
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context); //when pressed the option close the popup
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications() //shows settings ko permission
                      .then((_) => Navigator.pop(context)),
                  // close popup
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Color(0xFF0077B6),
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              "assets/images/logo.png",
            width: 150,
            height: 150,
          ),
          Text(
            "Home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0, bottom: 25.0),
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
                    child: MyDesign(),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 12.0),
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
                      child:
                      MySharedPreferences.getUsertype == UserType.COMPANY ?
                      Option(
                          image: "assets/icons/plus.png",
                          text: "My Requests",
                          link: "/bookingRequest"
                      )
                          :
                      Option(
                          image: "assets/icons/appointment.png",
                          text: "My \nAppointmnets",
                          link: "/viewappointment")),
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
                    child:Option(
                        image: "assets/icons/delivery.png",
                        text: "Vendors",
                        link: "/viewcompany"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12.0),
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
                    child:
                      MySharedPreferences.getUsertype == UserType.COMPANY ?
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Rates(company_id: MySharedPreferences.getLoginId!)));
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Image.asset(
                            "assets/icons/hand.png",
                            width: 54,
                            fit: BoxFit.fitHeight,
                          ),
                          SizedBox(width: 14.0),
                          Center(
                            child: Text("My Pricings", style: TextStyle(
                              fontSize: 12,
                            ), overflow: TextOverflow.fade),
                          )
                        ]),
                      )
                          : Option(image: "assets/icons/star.png", text: "Favourites", link: "/favorites")
                  )
                ],
              )
          ),
          Container(
              margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0, bottom: 0.0),
              padding: EdgeInsets.all(14.0),
              decoration: const BoxDecoration(
                color: Color(0x1216BA37),
                  border: Border(
                    left: BorderSide(
                      color:Color(0x6616BA37),
                      width: 5,
                    ),
                  )),
            child: InkWell(
              onTap: () {Navigator.pushNamed(context, "/about");},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        Image.asset(
                          "assets/icons/information.png",
                          width: 20,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 10.0),
                        Text("About Us"),
                      ]
                  ),
                  Text(
                      " > ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ]
              ),
            )
          ),
          SizedBox(height: 20.0),
          Container(
              margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0, bottom: 0.0),
              padding: EdgeInsets.all(14.0),
              decoration: const BoxDecoration(
                color: Color(0x31BCEBFD),
                  border: Border(
                    left: BorderSide(
                      color:Color(0x5150D6FF),
                      width: 5,
                    ),
                  )),
              child: InkWell(
                onTap: () {Navigator.pushNamed(context, "/help");},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/help.png",
                            width: 20,
                            fit: BoxFit.fitHeight,
                          ),
                          SizedBox(width: 10.0),
                          Text("Help"),
                        ]
                      ),
                      Text(
                        " > ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ]
                ),
              )
          )
        ],
      ),
    ))));
  }
}

class MyDesign extends StatelessWidget {
  const MyDesign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MySharedPreferences.getUsertype == UserType.COMPANY
        ? Option(
            image: "assets/images/view_request.jpg",
            text: "View all \n request",
            link: "/getAllBooking")
        : Option(
            image: "assets/icons/garbage-truck.png",
            text: "Order a \n pickup",
            link: "/orderpickup");
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
      onTap: () {
        Navigator.pushNamed(context, link.toString());
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.asset(
          "${image}",
          width: 54,
          fit: BoxFit.fitHeight,
        ),
        SizedBox(width: 14.0),
        Center(
          child: Text("${text}", style: TextStyle(
            fontSize: 12,
          ), overflow: TextOverflow.fade),
        )
      ]),
    );
  }
}
