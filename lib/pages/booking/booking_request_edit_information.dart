import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/custom/ButtonAsWidgetr.dart';
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/booking/booking_request_confirm.dart';
import 'package:login_sprint1/pages/booking/confirm_booking.dart';
import 'package:sweetalert/sweetalert.dart';

class EditInformation extends StatefulWidget {
  final Object data;
  const EditInformation(
      {Key? key, required this.data})
      : super(key: key);

  @override
  State<EditInformation> createState() =>
      _EditInformationState(data: data);
}

class _EditInformationState extends State<EditInformation> {
  var data;

  _EditInformationState(
      { required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.0),
              const Text(
                "Edit Information",
                style: kTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "User: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      data["user"]["name"],
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
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
  const ColumnStart(
      {Key? key, required this.data})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ColumnStartState(data: data);
}

class _ColumnStartState extends State<ColumnStart> {
  String date = "";
  String time = "";
  String location = "";

  var data;

  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;


  var body = {};

  late TextEditingController dateinput;
  late TextEditingController timeinput;
  late TextEditingController locationinput;

  @override
  void initState() {
    dateinput = TextEditingController(text: data["datetime"].toString().substring(0, 10));
    timeinput = TextEditingController(text: data["datetime"].toString().substring(11, 16));
    locationinput = TextEditingController(text: data["location"]);

    year = int.parse(data["datetime"].toString().substring(0, 4));
    month = int.parse(data["datetime"].toString().substring(5, 7));
    day = int.parse(data["datetime"].toString().substring(8, 10));
    hour = int.parse(data["datetime"].toString().substring(11, 13));
    minute = int.parse(data["datetime"].toString().substring(14, 16));

  }



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
          ButtonAsWidget(
            buttonColor: Color(0xff0077B6),
            onClick: () {
              var datetime = DateTime(
                  year,
                  month,
                  day,
                  hour,
                  minute
              ).toLocal();
              print("hour "+ hour.toString());
              var dt = datetime.toString();

              data["datetime"] = dt;
              data["location"] = locationinput.text;

              print(data);

              Navigator.push(context, MaterialPageRoute(builder: (builder) => BookingRequestConfirm(data: data)));

              List<String> myAllSavedData = SaveLocalData.getSavedData;
              print(myAllSavedData[0]);
            },
            buttonText: "Confirm Information",
          ),
        ],
      ),
    );
  }
}