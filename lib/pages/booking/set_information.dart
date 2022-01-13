import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/custom/ButtonAsWidgetr.dart';
import 'package:login_sprint1/pages/Constraints.dart';
import 'package:login_sprint1/pages/booking/confirm_booking.dart';
import 'package:sweetalert/sweetalert.dart';

class SetInformation extends StatefulWidget {
  final String name;
  final String id;
  final Object body;
  const SetInformation(
      {Key? key, required this.name, required this.id, required this.body})
      : super(key: key);

  @override
  State<SetInformation> createState() =>
      _SetInformationState(name: name, id: id, body: body);
}

class _SetInformationState extends State<SetInformation> {
  String id;
  String name;
  var body;

  _SetInformationState(
      {required this.name, required this.id, required this.body});

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "Company: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      this.name,
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
              ColumnStart(id: id, data: body, name: name),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnStart extends StatefulWidget {
  final String id;
  final Object data;
  final Object name;
  const ColumnStart(
      {Key? key, required this.id, required this.data, required this.name})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ColumnStartState(id: id, data: data, name: name);
}

class _ColumnStartState extends State<ColumnStart> {
  String date = "";
  String time = "";
  String location = "";
  String id;
  var data;
  var name;

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

  _ColumnStartState({required this.id, required this.data, required this.name});

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
              SweetAlert.show(context,
                  title: "Are u sure u wanna book",
                  style: SweetAlertStyle.confirm,
                  showCancelButton: true, onPress: (bool isConfirm) {

                    if (isConfirm) {
                      var datetime = DateTime.utc(
                          year,
                          month,
                          day,
                          hour,
                          minute
                      ).toLocal();
                      var dt = datetime.toString();

                      body = {
                        "company" : id,
                        "datetime" : dt,
                        "location" : location,
                        "items": data["items"],
                        "total_price": data["total_price"]
                      };

                      Navigator.push(context, MaterialPageRoute(builder: (builder) => ConfirmBooking(data: body, name: name)));


                      // SweetAlert.show(context,
                      //     style: SweetAlertStyle.success, title: "Success");
                      List<String> myAllSavedData = SaveLocalData.getSavedData;
                      print(myAllSavedData[0]);
                      // for (var i in myAllSavedData) {
                      //   print("Your saved data is --> $i");
                      // }
                      // return false to keep dialog
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