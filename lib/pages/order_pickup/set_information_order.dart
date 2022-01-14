import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/custom/ButtonAsWidgetr.dart';
import 'package:login_sprint1/pages/order_pickup/confirm_order.dart';
import 'package:sweetalert/sweetalert.dart';

import '../../constraints/constraints.dart';

class SetInformationOrder extends StatefulWidget {
  final Object data;
  const SetInformationOrder({Key? key, required this.data}) : super(key: key);

  @override
  _SetInformationOrderState createState() => _SetInformationOrderState(data: data);
}

class _SetInformationOrderState extends State<SetInformationOrder> {
  Object data;
  _SetInformationOrderState({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.0),
              const Text(
                kSetInformationTitle,
                style: kTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              SizedBox(
                height: 10.0,
              ),
              ColumnStart(data: data),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnStart extends StatefulWidget {
  final Object data;
  const ColumnStart({Key? key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnStartState(data: data);
}


class _ColumnStartState extends State<ColumnStart> {
  String date = "";
  String time = "";
  String location = "";
  var data;


  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;


  var body = {};

  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  void initState() {
    dateinput.text = "";
  }

  TextEditingController locationinput = TextEditingController();
  // void initState() {
  //   dateinput.text = "";
  // }

  _ColumnStartState({ required this.data });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                readOnly:
                true, //set it true, so that user will not able to edit text

                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030));
                  if (pickedDate != null) {
                    String formateDate =
                    DateFormat("yyyy-MM-dd").format(pickedDate);
                    SaveLocalData.savedData(formateDate);

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
                onChanged: (value) {
                  setState(() => location = value);
                },
                controller: locationinput,
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
                controller: timeinput,
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
          ButtonAsWidget(
            buttonColor: Color(0xff0077B6),
            onClick: () {
              SweetAlert.show(context,
                  title: "Are u sure u wanna book",
                  style: SweetAlertStyle.confirm,
                  showCancelButton: true, onPress: (bool isConfirm) {
                    if (isConfirm) {

                      var datetime = DateTime.utc(
                          year,
                          month,
                          day,
                          hour.toInt(),
                          minute.toInt()
                      ).toLocal();
                      var dt = datetime.toString();
                      print(dt);
                      body = {
                        "datetime" : dt,
                        "location" : location,
                        "items": data
                      };

                      Navigator.push(context, MaterialPageRoute(builder: (builder) => ConfirmOrder(data: body, time: hour.toString() + ":" + minute.toString() )));

                      List<String> myAllSavedData = SaveLocalData.getSavedData;
                      return false;
                    }
                    return true;
                  });
            },
            buttonText: "Confirm Booking",
          ),
        ],
      ),
    );
  }
}