import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';

class CompanyView {
  var baseUri = "$BASEURI/user";

  Future<dynamic> getCompany() async {
    try {
      var response = await http
          .get(Uri.parse("$baseUri/get_company"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          });

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> oneCompany(id) async {
    try {
      var response = await http
          .get(Uri.parse("$baseUri/showOne/${id}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          });

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }


}