import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/ratings_services.dart';

void main() async {
  test("insert ratings test", () async {
    bool expected = true;
    var company_id = "61d96a36687290929a25f3c9";
    var body = {"rating":3};
    var ratings_services= RatingsServices();
    var response = await ratings_services.insertRatings(body, company_id);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}
