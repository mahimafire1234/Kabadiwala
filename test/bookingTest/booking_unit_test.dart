

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
      "datetime" : "12-12-2021 14:00",
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

  test("booking update test for company", () async {
    bool expected = true;

    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJZb3VySUQiOiI2MWUxNzFjM2FkY2E0YTdlMzM5MmE5ZTkiLCJpYXQiOjE2NDIyNDM2NjR9.HSrd8he2VNS47wNp3WLXn0eIu6mgN23ss_q24-McSZI";
    var bookingServices = BookingServices();
    var body = {
      "date" : "12-12-2021 12:00",
      "location" : "udpated location",
      "items": [
        {
          "_id" : "61dfd5d003ac4e4241a70e09",
          "category" : "Glass",
          "amount" : "1",
          "category_price" : "12",
        }
      ],
      "total_price": "12"
    };
    var id = "61dfd59703ac4e4241a70df9";
    var response = await bookingServices.updateBookingCompany(id, body, token);
    var resBody = await json.decode(response.toString());
    var received = resBody["success"];
    expect(expected, received);
  });

}