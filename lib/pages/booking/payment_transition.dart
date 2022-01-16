import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/services/booking_services.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class PaymentTransition extends StatefulWidget {
  String? startingValue;

  PaymentTransition({Key? key}) : super(key: key);

  Future<List<dynamic>> getPaymentTransition() async {
    List<dynamic>? pendingList = [];
    try {
      var response = await BookingServices.getPayTransition(
        MySharedPreferences.getUsertype,
        MySharedPreferences.getLoginId,
      );
      print("data type is ${MySharedPreferences.getUsertype}");
      print("id type is -------------${MySharedPreferences.getLoginId}");
      var data = await jsonDecode(response);
      print("data for payment =======>>>>>${data["data"]}");

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
  _PaymentTransitionState createState() => _PaymentTransitionState();
}

class _PaymentTransitionState extends State<PaymentTransition> {
  String? setValue = "pending";
  Future<List<dynamic>>? getSelectedFunction() {
    return widget.getPaymentTransition();
  }

  @override
  void initState() {
    widget.getPaymentTransition();
    print(SaveLocalData.getMySavedData.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Kabadiwala"), backgroundColor: Color(0xff0077B6)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "View Transaction history",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                  ),
                  height: 90,
                ),
              ),
              Center(
                child: RenderMyCustomWidget(
                  setFunction: getSelectedFunction(),
                  userType: MySharedPreferences.getUsertype == UserType.USER
                      ? UserType.COMPANY
                      : UserType.USER,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RenderMyCustomWidget extends StatefulWidget {
  final Future<List<dynamic>>? setFunction;
  final String? userType;

  const RenderMyCustomWidget(
      {Key? key, this.setFunction, required this.userType})
      : super(key: key);

  @override
  State<RenderMyCustomWidget> createState() => _RenderMyCustomWidgetState();
}

class _RenderMyCustomWidgetState extends State<RenderMyCustomWidget> {
  @override
  Widget build(BuildContext context) {
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
                  itemBuilder: (BuildContext context, dynamic index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      height: 150.0,
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
                                "Transition : ${snapshot.data![index]["${widget.userType}"]["name"]}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Price  ${snapshot.data![index]["total_price"]}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Location  ${snapshot.data![index]["location"]}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Date  ${snapshot.data![index]["datetime"].toString().substring(0, 10)}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Time  ${snapshot.data![index]["datetime"].toString().substring(11, 16)}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, dynamic index) =>
                      const Divider(),
                )
              : Text("null");
        },
      ),
    );
  }
}
