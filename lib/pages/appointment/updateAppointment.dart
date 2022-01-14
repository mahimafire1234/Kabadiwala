import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/pages/appointment/viewAppointment.dart';
import 'package:login_sprint1/services/shared_preference.dart';

import '../Constraints.dart';

class UpdateAppointment extends StatefulWidget {
  String bookingID;
  String oldlocation;
  String olddatetime;

  UpdateAppointment(
      {required this.bookingID, required this.oldlocation, required this.olddatetime});

  @override
  _UpdateAppointmentState createState() =>
      _UpdateAppointmentState(bookingID,oldlocation,olddatetime);
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  String bookingID;
  String oldlocation;
  String olddatetime;

  _UpdateAppointmentState(this.bookingID, this.oldlocation,this.olddatetime);
  String datetime = "";
  String location ="";

  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;

  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();

  void initState() {
    dateinput.text = "";
  }


  updateData() async {
    try {
      String? user_id = MySharedPreferences.getLoginId;
      var data = {"location": location,"datetime":dateinput};
      var body = await json.encode(data);
      print("body");
      print(body);
      var response = await http.put(
          Uri.parse(
              "http:192.168.137.50/booking/updateAppointment/${user_id}/${bookingID}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: body);
      return response.body;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40.0),
          Center(
            child: const Text(
              kUpdateAppointmentTitle,
              style: kTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 5.0,
              shadowColor: const Color(0xff2a2a2a),
              borderRadius: BorderRadius.circular(25),
              child: TextFormField(
                controller: dateinput,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(

                    // contentPadding: EdgeInsets.only(left: 80.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none),
                    hintText: "DD/MM/YYY",
                    prefixIcon:
                        Icon(Icons.calendar_today, color: Colors.black)),
                readOnly: true,
                //set it true, so that user will not able to edit text

                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030));
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formateDate =
                        DateFormat("yyyy-MM-dd").format(pickedDate);
                    SaveLocalData.savedData(formateDate);
                    print(formateDate);

                    this.year = pickedDate.year;
                    this.month = pickedDate.month;
                    this.day = pickedDate.day;

                    setState(() {
                      dateinput.text = formateDate;
                    });
                  } else {
                    print("date is not selected");
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 5.0,
              shadowColor: const Color(0xff2a2a2a),
              borderRadius: BorderRadius.circular(25),
              child: TextFormField(
                initialValue: oldlocation,
                onChanged: (value) {
                  setState(() => {location = value});
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    // contentPadding: EdgeInsets.only(left: 80.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none),
                    hintText: "Location",
                    prefixIcon:
                        Icon(CupertinoIcons.location, color: Colors.black)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 5.0,
              shadowColor: const Color(0xff2a2a2a),
              borderRadius: BorderRadius.circular(25),
              child: TextFormField(
                initialValue: datetime,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(

                    // contentPadding: EdgeInsets.only(left: 80.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none),
                    hintText: "Time",
                    prefixIcon: Icon(
                      CupertinoIcons.time,
                      color: Colors.black,
                    )),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? timepicker = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (timepicker != null) {
                    this.hour = timepicker.hour;
                    this.minute = timepicker.minute;

                    print(timepicker.format(context));
                    String parseTime = timepicker.format(context);
                    SaveLocalData.savedData(parseTime);
                    setState(() {
                      timeinput.text = parseTime.toString();
                    });
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton(
                  onPressed: () async {
                    var response = await updateData();
                    var res = json.decode(response);
                    print(res["success"]);
                    final snackB = SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(res["message"]),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackB);
                    if(res["success"] == true){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=> ViewAppointment()));
                    }
                    if(res["success"] == false){
                      print("error");
                    }
                  },
                  child: const Text(
                    "Update Appointment",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 2, 7, 153)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 119, 182)),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(25.0))))),
            ),
          )
        ],
      ),
    )));
  }
}
