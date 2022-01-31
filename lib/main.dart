import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'custom/info_slider_page.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/notification',
    [
      NotificationChannel(
        channelKey:
            'scheduled_channel', //shown when enabling permission in the setting
        channelName: 'Reminder', //name shown in setting
        defaultColor:
            const Color(0xFF0077B6), //default color of the notification
        importance:
            NotificationImportance.High, //display notification on screen
        //channelShowBadge: true, // to show number of notification badge on app icon
        locked: true,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroSliderPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
