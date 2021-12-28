import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/Category.dart';

class UserServices{
  Future<String?> signup(body) async {
    try {
      var response = await http
          .post(Uri.parse("http://10.0.2.2:5000/user/register"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

//  get rates
  Future<Category?> getRate(id) async {
    try{
    //  url
      final fetchUrl = "http://10.0.2.2:5000/category/getRate/${id}";
      var response = await http.get(Uri.parse(fetchUrl));
      var result = response.body;
      return Category.fromJson(jsonDecode(result));
    }
    catch(error){
      print(error);
    }
  }

}