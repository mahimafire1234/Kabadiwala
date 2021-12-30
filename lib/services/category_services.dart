import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryServices{
  var baseUri = "http://10.0.2.2:5000/category";

  Future<String?> getRates(id) async {
    try {
      var response = await http
          .get(Uri.parse("${baseUri}/getRate/${id}"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          });
      return response.body;
    } catch (e) {
      print(e);
    }
  }



}