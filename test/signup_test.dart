import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/services/userservices.dart';

void main() async {
   test("User sign up", () async {
    bool expected = true;

    var userServices = UserServices();
    var body = {
      "name": "test",
      "email": "test1256@gmail.com",
      "number": "2393939",
      "type": "normal",
      "password": "test"
    };
    var response = await userServices.signup(body);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });

}