import 'dart:ui';

import 'package:flutter/material.dart';

class BookingRequest extends StatefulWidget {
  const BookingRequest({Key? key}) : super(key: key);

  @override
  _BookingRequestState createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  String? _startingValue;

  List<String> itemList = <String>["pending", "accepted", "rejected"];
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
                        value: _startingValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            _startingValue = newValue as String;
                            print(_startingValue);
                          });
                        },
                        items: itemList.map((String value1) {
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
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(20),
                    // shrinkWrap: true,
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 220,
                        child: Card(
                          shadowColor: Colors.black,
                          semanticContainer: true,
                          elevation: 2,
                          margin: EdgeInsets.all(20.0),
                          child: Text("Order from user"),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
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
