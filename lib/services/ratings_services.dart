import 'package:http/http.dart' as http;
import 'dart:convert';

class RatingsServices{
  Future<dynamic> insertRatings(body,company_id) async {
    try {
      var response = await http.post(Uri.parse("http://10.0.2.2:5000/rate/giveRate/${company_id}"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
        body: json.encode(body),
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }
}