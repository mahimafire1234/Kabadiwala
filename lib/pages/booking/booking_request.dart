import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/pages/booking/booking_request_confirm.dart';
import 'package:login_sprint1/services/booking_services.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class BookingRequest extends StatefulWidget {
  String? startingValue;
  String? approvedValue = "accepted";
  String? declinedValue = "rejected";
  String? username;
  // String? userType;
  List<String> itemList = <String>["pending", "accepted", "rejected"];

  BookingRequest({Key? key}) : super(key: key);

  Future<List<dynamic>> getApproved() async {
    List<dynamic>? approvedList = [];
    try {
      var response = await BookingServices.getApprovedOnly(
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
      var response = await BookingServices.getDeclinedOnly(
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
      var response = await BookingServices.getPendingOnly(
          MySharedPreferences.getId, MySharedPreferences.getToken());
      var data = json.decode(response);
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
  _BookingRequestState createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  String? setValue = "pending";
  Future<List<dynamic>>? getSelectedFunction() {
    if (setValue == "rejected") {
      return widget.getRejected();
    } else if (setValue == "pending") {
      return widget.getPending();
    } else if (setValue == "accepted") {
      return widget.getApproved();
    } else {
      return widget.getPending();
    }
  }

  @override
  void initState() {
    widget.getPending();
    print(SaveLocalData.getMySavedData.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Request Pending",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Color(0xFF0077B6)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 150, top: 20),
                  child: Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0)),
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.white,
                      shadowColor: const Color(0xff2a2a2a),
                      child: DropdownButton(
                        alignment: Alignment.center,
                        hint: Text("choose request"),
                        value: setValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            setValue = newValue!;
                          });
                        },
                        items: widget.itemList.map((String value1) {
                          return DropdownMenuItem<String>(
                            value: value1,
                            child: Text(value1),
                          );
                        }).toList(),
                        isDense: true,
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RenderMyCustomWidget(
                    selectedValue: setValue!,
                    setFunction: getSelectedFunction()),
              ],
            ),
          ),
        ),
      ),
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
    if (widget.selectedValue == "rejected") {
      return AcceptedRejectedWidget(
          setFunction: widget.setFunction,
          statusColor: Colors.red,
          status: "Rejected");
    } else if (widget.selectedValue == "accepted") {
      return AcceptedRejectedWidget(
        setFunction: widget.setFunction,
        statusColor: Colors.green,
        status: "Accepted",
      );
    } else {
      return SizedBox(
        height: 400,
        child: FutureBuilder<List<dynamic>>(
          future: widget.setFunction,
          builder: (context, snapshot) {
            return (snapshot.hasData == true)
                ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(20),
                    // shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 100.0,
                        child: Card(
                          shadowColor: Colors.black,
                          semanticContainer: true,
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30.0),
                                child: Text(
                                  "Order Form ${snapshot.data![index]["user"]["name"]}",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await BookingServices.approved(
                                              snapshot.data![index]["_id"],
                                              MySharedPreferences.getToken());
                                          setState(() {
                                            snapshot.data!.removeAt(index);
                                          });
                                        },
                                        child: Text("Approved"),
                                        style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(150.0, 20.0)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            )))),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await BookingServices.declined(
                                              snapshot.data![index]["_id"],
                                              MySharedPreferences.getToken());
                                          setState(() {
                                            snapshot.data!.removeAt(index);
                                          });
                                        },
                                        child: Text("Declined"),
                                        style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(150.0, 20.0)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            )))),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  )
                : Text("null");
          },
        ),
      );
    }
  }
}

class AcceptedRejectedWidget extends StatelessWidget {
  final Color statusColor;
  final String status;
  final Future<List<dynamic>>? setFunction;
  const AcceptedRejectedWidget(
      {Key? key,
      required this.statusColor,
      required this.setFunction,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: FutureBuilder<List<dynamic>>(
        future: setFunction,
        builder: (context, snapshot) {
          return (snapshot.hasData == true)
              ? ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(20),
                  // shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      height: 190.0,
                      child: Card(
                        shadowColor: Colors.black,
                        semanticContainer: true,
                        elevation: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30.0),
                                  child: Text(
                                    "Status: ",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: statusColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    "Booked by ${snapshot.data![index]["user"]["name"]}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    "Date: ${snapshot.data![index]["date"]}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    "Time: ${snapshot.data![index]["time"]}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Center(
                                child: Text(
                                  "Total cost: Rs.${snapshot.data![index]["total_price"]}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => BookingRequestConfirm( data: snapshot.data![index] ),
                                    ));
                                  },
                                  child: Text("Complete"),

                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                )
              : Text("null");
        },
      ),
    );
  }
}
