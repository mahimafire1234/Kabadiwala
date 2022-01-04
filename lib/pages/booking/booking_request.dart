import 'package:flutter/material.dart';

class BookingRequest extends StatefulWidget {
  const BookingRequest({Key? key}) : super(key: key);

  @override
  _BookingRequestState createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  List<String> itemList = <String>[
    "selected Item",
    "pending",
    "accepted",
    "rejected"
  ];
  String startingValue = "";
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
                DropdownButton(
                  value: "pending",
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      startingValue = newValue!;
                    });
                  },
                  items: itemList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
