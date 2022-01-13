import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanyView{
  var baseUri = "http://127.0.0.1:5000/user";

  Future<dynamic> getCompany() async {
    try {
      var response = await http
          .get(Uri.parse("http://127.0.0.1:5000/user/get_company"),
          headers: {
            'Content-type' : 'application/json',
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
          .get(Uri.parse("http://127.0.0.1:5000/user/showOne/${id}"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          });

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

}