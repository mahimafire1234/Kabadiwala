import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/services/category_services.dart';

void main() async {
  test("Update rate test", () async {
    bool expected = true;
    var company_id = "61d4627f2583ce797f222e6c";
    var object_id = "61d47669ffb40aeeb00078f8";
    var body = {"price":"100"};
    var categoryServices = CategoryServices();
    var response = await categoryServices.updateRate(body,company_id, object_id);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}
