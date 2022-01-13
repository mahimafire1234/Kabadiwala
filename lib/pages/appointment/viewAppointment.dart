import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/services/booking_services.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class ViewAppointment extends StatefulWidget {

  String? startingValue;
  String? approvedValue = "Accepted";
  String? declinedValue = "Rejected";

  // String? userType;
  List<String> statusList = <String>["Pending", "Accepted", "Rejected"];

  ViewAppointment({Key? key}) : super(key: key);

  Future<List<dynamic>> getApproved() async {
    List<dynamic>? approvedList = [];
    try {
      var response = await BookingServices.viewApprovedOnly(
          MySharedPreferences.getId, MySharedPreferences.getToken());
      var data = jsonDecode(response);
      if (data["success"] == true) {
        var items = data["data"];
        for (dynamic i in items!) {
          print("The i is:-->$i");
          approvedList.add(i);
          print("The approved list is:-->$approvedList");
        }
      } else {
        print("there is error");
      }
    } on Exception {
      Exception("didnot hit rejected route");
    }
    return approvedList;
  }

  Future<List<dynamic>> getRejected() async {
    List<dynamic>? rejectedList = [];
    try {
      var response = await BookingServices.viewDeclinedOnly(
          MySharedPreferences.getId, MySharedPreferences.getToken());
      var data = jsonDecode(response);
      if (data["success"] == true) {
        var items = data["data"];
        for (dynamic i in items!) {
          rejectedList.add(i);
        }
      } else {
        print("there is error");
      }
    } on Exception {
      Exception("didnot hit rejected route");
    }
    return rejectedList;
  }

  Future<List<dynamic>> getPending() async {
    List<dynamic>? pendingList = [];
    try {
      var response = await BookingServices.viewPendingOnly(
          MySharedPreferences.getId, MySharedPreferences.getToken());
      var data = jsonDecode(response);
      if (data["success"] == true) {
        var items = data["data"];
        for (dynamic i in items!) {
          pendingList.add(i);
        }
      } else {
        print("there is error");
      }
    } on Exception {
      Exception("didnot hit rejected route");
    }
    return pendingList;
  }

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState();
}

// const ViewAppointments({Key? key}) : super(key: key);

class _ViewAppointmentState extends State<ViewAppointment> {
  String selectedValue = "Pending";

  Future<List<dynamic>>? getSelectedFunction() {
    if (selectedValue == "Rejected") {
      return widget.getRejected();
    } else if (selectedValue == "Pending") {
      return widget.getPending();
    } else if (selectedValue == "Accepted") {
      return widget.getApproved();
    } else {
      return widget.getPending();
    }
  }

  @override
  void initState() {
    widget.getPending();
    print(SaveLocalData.getSavedData.length);
    super.initState();
  }

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
            child:SingleChildScrollView(
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          children: [
                            Text(
                              "My appointments",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                  color: Color(0xFF0077B6)),
                            ),
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
                                      value: selectedValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValue = newValue! as String;
                                          print(selectedValue);
                                        });
                                      },
                                      items: widget.statusList.map((String value1) {
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
                                RenderMyCustomWidget(
                                  selectedValue: selectedValue!,
                                  setFunction: getSelectedFunction(),
                                ),
                              ],
                            ),
                          ]
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }
}
class RenderMyCustomWidget extends StatefulWidget {
  final String selectedValue;
  final Future<List<dynamic>>? setFunction;

  const RenderMyCustomWidget(
      {Key? key, required this.selectedValue, required this.setFunction})
      : super(key: key);

  @override
  State<RenderMyCustomWidget> createState() => _RenderMyCustomWidgetState();
}

class _RenderMyCustomWidgetState extends State<RenderMyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:900,
        child:FutureBuilder<List<dynamic>>(
            future:widget.setFunction,
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
                                            .data![i]["status"] == "pending")
                                          Text(
                                            snapshot.data![i]["status"]
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                        if (snapshot.data![i]["status"] == "accepted")
                                          Text(
                                            snapshot.data![i]["status"]
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                Colors.green),
                                          ),
                                        if (snapshot
                                            .data![i]["status"] == "rejected")
                                          Text(
                                            snapshot.data![i]["status"]
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.red),
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
                                            snapshot.data![i]["user"],
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
                                            snapshot.data![i]["date"],
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
                                            snapshot.data![i]["time"],
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
                                                .data![i]["location"],
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
                                            ["total_price"].toString(),
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
            }
        )
    );
  }
}