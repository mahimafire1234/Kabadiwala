import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/services/booking_services.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class BookingRequest extends StatefulWidget {
  String? startingValue;
  String? approvedValue = "";
  String? declinedValue = "rejected";
  String? username;
  // String? userType;
  List<String> itemList = <String>["pending", "accepted", "rejected"];

  BookingRequest({Key? key}) : super(key: key);

  Future<List<String>> getBookingData() async {
    List<String>? userList = [];

    try {
      var response =
          await BookingServices.getAllBooking(MySharedPreferences.getToken());

      var data = await json.decode(response);
      if (data["success"] == true) {
      } else {}
      var items = data["data"];
      for (dynamic i in items!) {
        username = i["user"]["name"];
        // userType = i["user"]["userType"];
        String name = i["user"]["name"];
        userList.add(name);
      }
    } on Exception {
      Exception("invalid login");
    }
    return userList;
  }

  // getApproved() async {
  //   var response =
  //       await BookingServices.approved(id, status,MySharedPreferences.getToken());
  // }

  @override
  _BookingRequestState createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  @override
  void initState() {
    widget.getBookingData();
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
                        value: widget.startingValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            widget.startingValue = newValue as String;
                          });
                          print(widget.startingValue);
                          var getSelectedValue = widget.startingValue;

                          if (getSelectedValue == "rejected") {
                            RequestHandler.getRejected();
                          }
                          if (getSelectedValue == "accepted") {
                            RequestHandler.getApproved();
                          }
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

                SizedBox(
                  height: 400,
                  child: FutureBuilder<List<String>>(
                    future: widget.getBookingData(),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  height: 100.0,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    semanticContainer: true,
                                    elevation: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            "Order Form ${snapshot.data![index]}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    var approvedValue =
                                                        "accepted";
                                                    var response =
                                                        await BookingServices.approved(
                                                            MySharedPreferences
                                                                .getId,
                                                            approvedValue,
                                                            MySharedPreferences
                                                                .getToken());
                                                    print(response);
                                                  },
                                                  child: Text("Approved"),
                                                  style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  150.0, 20.0)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.green),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      )))),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    var declinedValue =
                                                        "reject";

                                                    var response =
                                                        await BookingServices.declined(
                                                            MySharedPreferences
                                                                .getId,
                                                            declinedValue,
                                                            MySharedPreferences
                                                                .getToken());
                                                    print(response);
                                                  },
                                                  child: Text("Declined"),
                                                  style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  150.0, 20.0)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.red),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      )))),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            )
                          : Text("null");
                    },
                  ),
                )
                // items: Ritems.map((String value) {
                //   return DropdownMenuItem<String>(
                //     child: Text(value),
                //     value: value,
                //   );
                // }).toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequestHandler extends StatefulWidget {
  static getApproved() async {
    try {
      var response = await BookingServices.getApprovedOnly(
          MySharedPreferences.getId, MySharedPreferences.getToken());
      var data = jsonDecode(response);
      print(data["data"]);
    } on Exception {
      Exception("didnot hit rejected route");
    }
  }

  static getRejected() async {
    try {
      var response = await BookingServices.getDeclinedOnly(
          MySharedPreferences.getId, MySharedPreferences.getToken());
      var data = jsonDecode(response);
      print(data["data"]);
    } on Exception {
      Exception("didnot hit rejected route");
    }
  }

  const RequestHandler({Key? key}) : super(key: key);

  @override
  _RequestHandlerState createState() => _RequestHandlerState();
}

class _RequestHandlerState extends State<RequestHandler> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
