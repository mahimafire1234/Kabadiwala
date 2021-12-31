import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/items.dart';

class CategoryServices{
  var baseUri = "http://10.0.2.2:5000/category";

  Future<List<CategoryRate>> getRates(id) async {
    try {
      var response = await http
          .get(Uri.parse("$baseUri/getRate/$id"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          });
      var data = json.decode(response.body);
      var categoryRate = data['data'][0]["category_rate"] as List;
      List<CategoryRate> cr = categoryRate.map(
              (item) => CategoryRate.fromJson(item)).toList();
      return cr;
    } catch (e) {
      print(e);
    }
    return [];
  }

}