import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/pages/insertrate.dart';
import 'package:login_sprint1/services/category_services.dart';
import 'package:login_sprint1/services/userservices.dart';

void main() async {
  test("insert rate test", () async {
    bool expected = true;
    var company_id = "61d4627f2583ce797f222e6c";
    var rate = [
      {"price": "931", "category": "Home"}
    ];
    var data = {"userID": company_id, "category_rate": rate};
    var userServices = UserServices();
    var response = await userServices.insertRate(data);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });

  //rate for one company test
  test("rate for one company test", () async {
    var id = "61d4627f2583ce797f222e6c";
    var getrateservices = CategoryServices();
    var result = await getrateservices.getRates(id);
    var expected = "200";
    var actual = result.toString();
    debugPrint(actual);
    expect(expected, actual);
  });
}
