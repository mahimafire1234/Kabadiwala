// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:login_sprint1/main.dart';
import 'package:login_sprint1/services/userservices.dart';

void main() {
  test("User sign up", () async* {
    bool expected = true;

    var userServices = UserServices();
    var body = {
      "name": "test",
      "email": "test1234@gmail.com",
      "number": "2393939",
      "type": "normal",
      "password": "test"
    };
    var response = await userServices.signup(body);
    var resBody = json.decode(response);
    bool received = resBody["success"];
    expect(expected, received);
  });
}
