import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/services/userservices.dart';

void main() async {
   test("User sign up", () async {
    bool expected = true;

    var userServices = UserServices();
    var body = {
      "name": "kabadiwala",
      "email": "kab123@gmail.com",
      "phone": "2393939",
      "usertype": "company",
      "password": "kab"
    };
    var response = await userServices.signup(body);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });

}
