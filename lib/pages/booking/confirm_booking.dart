import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_sprint1/services/booking_services.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class ConfirmBooking extends StatefulWidget {
  final Object data;
  final String name;
  final id;

  const ConfirmBooking(
      {Key? key, required this.data, required this.name, this.id})
      : super(key: key);

  @override
  _ConfirmBookingState createState() =>
      _ConfirmBookingState(data: data, name: name, id: id);
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  var name;
  var data;

  _ConfirmBookingState({required this.data, required this.name, id});

  book() async {
    try {
      await MySharedPreferences.init();
      final token = await MySharedPreferences.getToken();

      var bookingServices = BookingServices();
      var response = await bookingServices.book(data, token);
      var decodedData = jsonDecode(response!);

      var res = json.decode(response);
      if (res['success']) {
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

        Navigator.pushNamed(context, "/home");
      }

      print(decodedData);
      var bookinId = decodedData["data"]["_id"];
      await MySharedPreferences.setId(bookinId);
      print(bookinId);

      return response;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0077B6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: 400,
              height: 800,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(19),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "< Edit",
                                  style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Rubik'),
                                ))
                          ]),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Text(
                          'Confirm Booking',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF0077B6),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                      CustomRow(text1: "Company", text2: name),
                      CustomRow(text1: "Date",
                          text2: data["datetime"].toString().substring(0, 10)),
                      CustomRow(
                          text1: "Location",
                          text2: data["location"].toString()),
                      CustomRow(text1: "Time",
                          text2: data["datetime"].toString().substring(11, 16)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: const [
                            Text(
                              'Items',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              'Name',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 0, 35, 0),
                            child: Text(
                              'Rate(Rs.)',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          Text(
                            'Quantity',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Divider(color: Colors.black),
                      ),
                      Column(children: [

                        for (var item in data["items"])
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Rubik'),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(35, 0, 90, 0),
                                  child: Text(
                                    (int.parse(item["category_price"]) /
                                            int.parse(item["amount"]))
                                        .floor()
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rubik'),
                                  ),
                                ),
                                Text(item["amount"])
                              ],
                            ),
                          )
                      ]),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Divider(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total: ',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data["total_price"].toString(),
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/viewcompany");
                                },
                                child: Text("Cancel"),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFFFFFF),
                                  onPrimary: Color(0xFF0077B6),
                                )),
                            SizedBox(width: 10.0),
                            ElevatedButton(
                              onPressed: () async {
                                var res = await book();
                              },
                              child: Text("Confirm Booking"),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String text1, text2;

  const CustomRow({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$text1: ',
            style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik'),
          ),
          Text(
            text2,
            style: TextStyle(
                color: Color(0xFFF2662A),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik'),
          ),
        ],
      ),
    );
  }
}
