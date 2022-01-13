import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/services/companyview.dart';
void main() {
  //test case for show all companies
  test("get company list test", () async {
    var companyservices = CompanyView();
    var result = await companyservices.getCompany();
    var expected = "200";
    var actual = result.toString();
    debugPrint(actual);
    expect(expected, actual);
  });
  //test case for show one company
  test("one company test", () async {
    var id = "61d4627f2583ce797f222e6c";
    var companyservices = CompanyView();
    var result = await companyservices.oneCompany(id);
    var expected = "200";
    var actual = result.toString();
    debugPrint(actual);
    expect(expected, actual);
  });
}