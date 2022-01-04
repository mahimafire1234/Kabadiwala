import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:login_sprint1/pages/base.dart';
import 'package:login_sprint1/pages/insertrate.dart';
import 'package:login_sprint1/pages/booking/items.dart';
import 'package:login_sprint1/pages/login.dart';
import 'package:login_sprint1/pages/myprofileUser.dart';
import 'package:login_sprint1/pages/myprofilekabadiwala.dart';
import 'package:login_sprint1/pages/oneCompany.dart';
import 'package:login_sprint1/pages/ratespage.dart';
import 'package:login_sprint1/pages/booking/set_information.dart';
import 'package:login_sprint1/pages/signup.dart';
import 'package:login_sprint1/pages/test.dart';
import 'package:login_sprint1/pages/viewcompany.dart';

void main() => runApp(const MyApp());

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
        '/viewcompany': (context) => const ViewCompany(),
        '/test': (context) => const ViewAppointment(),
        '/onecompany': (context) => oneCompany(id: '',),
        '/insertrate': (context) =>  InsertRate(company_id: '',),
        '/myprofilekabadiwala': (context) => const CompanyProfile(),
        '/myprofileuser': (context) => const UserProfile(),
        "/setInfo": (context) => SetInformation(name: '', id: '', body: ''),
        "/ratespage": (context) => Rates(company_id: '',),
        "/itemsHire": (context) => const ItemsHire(id: '', name: '')
      },
    );
  }
}
