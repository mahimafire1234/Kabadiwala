import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewAppointments extends StatefulWidget {
  String user_id;

  ViewAppointments({required this.user_id});

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState(user_id);

  Future<List<Appointment>?> getAppointments(id) async {
    try {
      final fetchUrl =
          "http://192.168.100.252:5000/booking/viewAppointments/${id}";
      print(id);
      print("hit");
      var response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
      var jsonData = await jsonDecode(response.body);
      print(jsonData);

      List<Appointment> appointment = [];
      for (var item in jsonData["data"]) {
        print(item);

        Appointment appointments = Appointment(
            item["user"],
            item["date"],
            item["time"],
            item["location"],
            item["status"],
            item["total_price"].toString());

        appointment.add(appointments);
        print("appointments");
      }
      return appointment;
    } catch (error) {
      print(error);
    }
  }
}

// const ViewAppointments({Key? key}) : super(key: key);

class _ViewAppointmentState extends State<ViewAppointments> {
  String user_id;
  String _selectedStatus = "Pending";

  _ViewAppointmentState(this.user_id);

  final List<String> status_list = ['Pending', 'Accepted', 'Rejected' ,'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () {},
            ),
            title: Center(child: Text("Kabadiwala")),
            backgroundColor: Color.fromARGB(255, 0, 119, 182)),
        body: SafeArea(
          child: Container(
              child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PhysicalModel(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          elevation: 5.0,
                          shadowColor: const Color(0xff2a2a2a),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                contentPadding: EdgeInsets.only(left: 20.0)),
                            value: _selectedStatus,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedStatus = newValue as String;
                                print(_selectedStatus);
                              });
                            },
                            items: status_list.map((String value1) {
                              return DropdownMenuItem<String>(
                                value: value1,
                                child: new Text(value1),
                              );
                            }).toList(),
                            isDense: true,
                            isExpanded: true,
                          ),
                        ),
                      ),
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        title: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      "Status : ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                    ),
                                                    if (snapshot
                                                            .data![i].status == "pending")
                                                      Text(
                                                        snapshot.data![i].status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors.grey),
                                                      ),
                                                    if (snapshot.data![i].status == "accepted")
                                                      Text(
                                                        snapshot.data![i].status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    if (snapshot
                                                            .data![i].status == "rejected")
                                                      Text(
                                                        snapshot.data![i].status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors.red),
                                                      ),
                                                    if (snapshot.data![i].status ==
                                                        "completed")
                                                      Text(
                                                        snapshot.data![i].status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors.orange),
                                                      ),
                                                  ]),
                                                  SizedBox(height: 10.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(children: [
                                                      Text(
                                                        "User : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        snapshot.data![i].user,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(children: [
                                                      Text(
                                                        "Date : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        snapshot.data![i].date,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(children: [
                                                      Text(
                                                        "Time : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        snapshot.data![i].time,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(children: [
                                                      Text(
                                                        "Location : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data![i].location,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        80, 10, 0, 10),
                                                    child: Row(children: [
                                                      Text(
                                                        "Total Price : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        snapshot.data![i]
                                                            .total_price,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
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

//class Appointment for get response
class Appointment {
  final String user, date, time, location, status, total_price;

  Appointment(this.user, this.date, this.time, this.location, this.status,
      this.total_price);
}
