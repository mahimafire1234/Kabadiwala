
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/services/userservices.dart';

void main() async{
  test("user details update test", () async {
    bool expected = true;

    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJZb3VySUQiOiI2MWRkOTk1ZDE2NTQ2NGUwMGRkYWQ4ZTYiLCJpYXQiOjE2NDI3NjExMzV9.axyLAUYQWaoPrxbTAKE9nEq5pQJaBRlt82WVjhC5z_s";

    var body = {
      "name" : "name changed",
    };

    var response = await UserServices.update(token, "", body, "asset");
    var resBody = await json.decode(response.toString());
    var received = resBody["success"];
    expect(expected, received);
  });

  test("password change test", () async {
    bool expected = true;

    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJZb3VySUQiOiI2MWRkOTk1ZDE2NTQ2NGUwMGRkYWQ4ZTYiLCJpYXQiOjE2NDI3NjExMzV9.axyLAUYQWaoPrxbTAKE9nEq5pQJaBRlt82WVjhC5z_s";

    var body = {
      "password" : "Sk12@",
      "newPassword" : "Sk13@",
    };

    var response = await UserServices.changePassword(token, body);
    var resBody = await json.decode(response.toString());
    var received = resBody["success"];
    expect(expected, received);
  });

}

