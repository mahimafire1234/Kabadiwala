import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryServices{
  var baseUri = "http://127.0.0.1:5000/category";

  //get rate for each company id
  Future<dynamic> getRates(id) async {
    try {
      var response = await http
          .get(Uri.parse("http://127.0.0.1:5000/category/getRate/$id"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          });

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> insertRate(body) async {
    try {
      var response =
      await http.post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
      // await http.post(Uri.parse("http://127.0.0.1:5000/category/insertRate"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateRate(body,company_id,object_id) async {
    try {
      var response =
      // await http.post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
      await http.put(Uri.parse("http://127.0.0.1:5000/category/updateRate/${company_id}/${object_id}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

}