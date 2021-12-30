import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';
import 'package:login_sprint1/custom/ButtonAsWidgetr.dart';
import 'package:login_sprint1/pages/Constraints.dart';
import 'package:sweetalert/sweetalert.dart';

class SetInformation extends StatelessWidget {
  const SetInformation({Key? key}) : super(key: key);

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
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: Row(
                  children: const [
                    Text(
                      "Company: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Rajiv karky",
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
              ColumnStart(),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnStart extends StatefulWidget {
  const ColumnStart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnStartState();
}

class _ColumnStartState extends State<ColumnStart> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController locationinput = TextEditingController();
  // void initState() {
  //   dateinput.text = "";
  // }

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
                  SweetAlert.show(context,
                      style: SweetAlertStyle.success, title: "Success");
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
