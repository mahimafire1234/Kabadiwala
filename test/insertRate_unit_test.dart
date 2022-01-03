import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/pages/insertrate.dart';
import 'package:login_sprint1/services/userservices.dart';

void main() async {
  test("insert rate test", () async {
    bool expected = true;

    var company_id = "1";
    InsertRate insertRate = InsertRate(company_id: company_id);
    var rate = [
      {"price": "12", "category": "Bottle"}
    ];
    var data = {"userID": company_id, "category_rate": rate};
    var body=await json.encode(data);
    var userServices = UserServices();
    var response = await userServices.insertRate(body);

    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}
