import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_sprint1/constraints/constraints.dart';

class RatingsServices{
  Future<dynamic> insertRatings(body,company_id) async {
    try {
      //url is for testing chnage it
      var response = await http.post(Uri.parse("$BASEURI/rate/giveRate/$company_id"),
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