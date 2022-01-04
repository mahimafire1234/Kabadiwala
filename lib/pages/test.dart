import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewAppointment extends StatefulWidget {
  const ViewAppointment({Key? key}) : super(key: key);

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'My Appointments',
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik'),
        ),
      ),
      Card(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      elevation: 8.0,
                      shadowColor: Color(0xff000f61),
                      child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children:[
                                    Text(
                                    "Status : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "Pending",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey
                                    ),
                                  )]),
                                  SizedBox(height: 10.0),
                                  Row(children: [
                                    Text("Hii"),
                                    SizedBox(width: 10.0),
                                  ]),
                                  SizedBox(height: 10.0),
                                  Row(children: [
                                    Text("Hii"),
                                    SizedBox(width: 10.0),
                                  ]),
                                  SizedBox(height: 10.0),
                                  Row(children: [
                                    Text("Hii"),
                                    SizedBox(width: 10.0),
                                  ]),
                                  SizedBox(height: 10.0),
                                  Row(children: [
                                    Text("Hii"),
                                    SizedBox(width: 10.0),
                                  ]),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ])))
    ]))));
  }
}
