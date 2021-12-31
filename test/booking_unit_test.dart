

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/services/booking_services.dart';
import 'package:login_sprint1/services/shared_preference.dart';

void main() async {
  test("booking test", () async {
    bool expected = true;

    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJZb3VySUQiOiI2MWNmMjFiYWJiNTQ3Y2RmYzYxMGNhMGUiLCJpYXQiOjE2NDA5NjQ1OTh9.CHuKdra-kwUEI-XnKxkPjLtoN7ACmR7i6tb4QsI3mPo";

    var bookingServices = BookingServices();
    var body = {
      "company" : "61cdd8583ca33ae26b8fd70f",
      "date" : "12-12-2021",
      "time" : "06:00 AM",
      "location" : "test location",
      "items": [
        {
          "category" : "bottle",
          "amount" : "1",
          "category_price" : "12",
        }
      ],
      "total_price": "12"
    };
    var response = await bookingServices.book(body, token);
    var resBody = await json.decode(response.toString());
    var received = resBody["success"];
    expect(expected, received);
  });

}