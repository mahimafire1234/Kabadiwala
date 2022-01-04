import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewAppointments extends StatefulWidget {
  String user_id;
  ViewAppointments({required this.user_id});

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState(user_id);

  getAppointments(String user_id) {}
}

  // const ViewAppointments({Key? key}) : super(key: key);

class _ViewAppointmentState extends State<ViewAppointments> {
  String user_id;
  _ViewAppointmentState(this.user_id);

  Future<List<Appointment>?> getAppointments(id) async {
    try {
      final fetchUrl = "http://10.0.2.2:5000/booking/viewAppointments/${id}";
      var response = await http.get(Uri.parse(fetchUrl));
      var jsonData = jsonDecode(response.body);
      
      List<Appointment> appointments = [];
      for (var a in jsonData["appointment"]) {
        Appointment appointment = Appointment(a["status"], a["date"], a["time"],
            a["items"], a["location"], a["user"]);
        appointments.add(appointment);
      }
      return appointments;
    }
    catch (error) {
      print(error);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                children: [
                  FutureBuilder<List<Appointment>?>(
                    future: widget.getAppointments(user_id),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(80.0),
                            child: Center(
                              child: Text("You have no appointments"),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                elevation: 10.0,
                                shadowColor: Color(0xff000f61),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![i].status,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(children: [
                                              Text(snapshot.data![i].date),
                                              SizedBox(width: 10.0),
                                              // Text(snapshot.data![i].id),
                                            ]),
                                            SizedBox(height: 10.0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    ));
  }
}

class Appointment {
  final String status, user, items, date, time, location;

  Appointment(
      this.status, this.user, this.items, this.date, this.time, this.location);
}
