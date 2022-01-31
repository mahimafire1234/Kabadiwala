import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/app/Help.dart';
import 'package:login_sprint1/pages/appointment/view_appointment.dart';
import 'package:login_sprint1/pages/base.dart';
import 'package:login_sprint1/pages/booking/booking_request.dart';
import 'package:login_sprint1/pages/booking/get_all_booking.dart';
import 'package:login_sprint1/pages/booking/items.dart';
import 'package:login_sprint1/pages/booking/payment_transition.dart';
import 'package:login_sprint1/pages/booking/set_information.dart';
import 'package:login_sprint1/pages/company/oneCompany.dart';
import 'package:login_sprint1/pages/company/viewcompany.dart';
import 'package:login_sprint1/pages/favorites/favorites.dart';
import 'package:login_sprint1/pages/order_pickup/order_pickup.dart';
import 'package:login_sprint1/pages/rates/insertrate.dart';
import 'package:login_sprint1/pages/rates/ratespage.dart';
//--no-sound-null-safety
import 'package:login_sprint1/pages/ratings/Ratings.dart';
import 'package:login_sprint1/pages/user/login.dart';
import 'package:login_sprint1/pages/user/myprofilekabadiwala.dart';
import 'package:login_sprint1/pages/user/signup.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => LoginPage(),
        '/home': (context) => const Base(index: 0),
        '/viewcompany': (context) => ViewCompany(),
        '/viewappointment': (context) => ViewAppointment(),
        '/viewcompany': (context) => ViewCompany(),
        '/viewappointment': (context) => ViewAppointment(),
        '/onecompany': (context) => oneCompany(
              companyID: '',
            ),
        '/insertrate': (context) => InsertRate(
              company_id: '',
            ),
        '/myprofilekabadiwala': (context) => const CompanyProfile(),
        '/bookingRequest': (context) => BookingRequest(),
        '/paymentRequest': (context) => PaymentTransition(),
        '/getAllBooking': (context) => GetAllBooking(),
        "/setInfo": (context) => SetInformation(name: '', id: '', body: ''),
        "/ratespage": (context) => Rates(
              company_id: '',
            ),
        "/itemsHire": (context) => const ItemsHire(id: '', name: ''),
        "/orderpickup": (context) => const OrderPickup(),
        "/rateCompany": (context) => RatingCompany(
              company_id: '',
            ),
        "/favorites": (context) => Favorites(),
        "/rateCompany": (context) => RatingCompany(
              company_id: '',
            ),
        "/help" : (context) => Help(),
      },
    );
  }
}
