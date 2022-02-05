import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/appointment/view_appointment.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class UpdateAppointment extends StatefulWidget {
  String bookingID;
  String oldlocation;
  String olddate;
  String oldtime;

  UpdateAppointment(
      {required this.bookingID,
      required this.oldlocation,
      required this.olddate,
      required this.oldtime});

  @override
  _UpdateAppointmentState createState() =>
      _UpdateAppointmentState(bookingID, oldlocation, olddate, oldtime);
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  String bookingID;
  String oldlocation;
  String olddate;
  String oldtime;

  _UpdateAppointmentState(
      this.bookingID, this.oldlocation, this.olddate, this.oldtime);

  String date = "";
  String time = "";
  String location = "";

  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;

  TextEditingController dateinput = new TextEditingController();
  TextEditingController timeinput = new TextEditingController();

  void initState() {
    dateinput.text = olddate;
    timeinput.text = oldtime;
  }

  updateData() async {
    try {
      String? user_id = MySharedPreferences.getLoginId;
      var datetime = DateTime.utc(year, month, day, hour, minute).toLocal();
      var dt = datetime.toString();
      print('dt $dt');

      var data = {"location": location, "datetime": dt};
      var body = await json.encode(data);
      print('body $body');

      var response = await http.put(
          Uri.parse("$BASEURI/booking/updateBook/${user_id}/${bookingID}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: body);
      print('res1 $response');
      return response.body;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Appointments"), backgroundColor: Color(0xff0077B6)),
        backgroundColor: Color(0xFF0077B6),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 80, 10, 10),
          child: Card(
              margin: EdgeInsets.all(10),
              elevation: 3.0,
              // this field changes the shadow of the card 1.0 is default
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.2),
                  borderRadius: BorderRadius.circular(20)),
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    SizedBox(height: 40.0),
                    Center(
                      child: const Text(
                        kUpdateAppointmentTitle,
                        style: kTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 30),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide.none),
                                        hintText: "DD/MM/YYY",
                                        prefixIcon: Icon(Icons.calendar_today,
                                            color: Colors.black)),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text

                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now().subtract(Duration(days: 0) ),
                                              lastDate: DateTime(2030));
                                      if (pickedDate != null) {
                                        print('pickedDate: $pickedDate');
                                        String formateDate =
                                            DateFormat("yyyy-MM-dd")
                                                .format(pickedDate);
                                        SaveLocalData.savedData(formateDate);
                                        print('formateDate: $formateDate');

                                        this.year = pickedDate.year;
                                        this.month = pickedDate.month;
                                        this.day = pickedDate.day;

                                        setState(() {
                                          dateinput.text = formateDate;
                                          print('dateinput $dateinput');
                                        });
                                      } else {
                                        print("date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 30),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 5.0,
                                  shadowColor: const Color(0xff2a2a2a),
                                  borderRadius: BorderRadius.circular(25),
                                  child: TextFormField(
                                    initialValue: oldlocation,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                        // contentPadding: EdgeInsets.only(left: 80.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide.none),
                                        hintText: "Location",
                                        prefixIcon: Icon(
                                            CupertinoIcons.location,
                                            color: Colors.black)),
                                    onChanged: (value) {
                                      setState(() => {location = value});
                                      print(location);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 30),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 5.0,
                                  shadowColor: const Color(0xff2a2a2a),
                                  borderRadius: BorderRadius.circular(25),
                                  child: TextFormField(
                                    controller: timeinput,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(

                                        // contentPadding: EdgeInsets.only(left: 80.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide.none),
                                        hintText: "Time",
                                        prefixIcon: Icon(
                                          CupertinoIcons.time,
                                          color: Colors.black,
                                        )),
                                    readOnly: true,
                                    onTap: () async {
                                      TimeOfDay? timepicker =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (timepicker != null) {
                                        this.hour = timepicker.hour;
                                        this.minute = timepicker.minute;

                                        print(
                                            'timepicker: $timepicker.format(context)');
                                        String parseTime =
                                            timepicker.format(context);
                                        SaveLocalData.savedData(parseTime);

                                        setState(() {
                                          timeinput.text = parseTime.toString();
                                          print('timeinput $timeinput');
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
                                        print('response $response');

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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackB);
                                        if (res["success"] == true) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewAppointment()));
                                        }
                                        if (res["success"] == false) {
                                          final snackB = SnackBar(
                                            duration: Duration(seconds: 5),
                                            content: Text("Failed to update"),
                                            action: SnackBarAction(
                                              label: 'Dismiss',
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackB);
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
                                              const Color.fromARGB(
                                                  255, 2, 7, 153)),
                                          backgroundColor: MaterialStateProperty.all(
                                              Color.fromARGB(255, 0, 119, 182)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25.0))))),
                                ),
                              )
                            ],
                          ),
                        ))
                  ]))),
        )))));
  }
}
