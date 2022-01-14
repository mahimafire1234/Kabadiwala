import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';

class CategoryServices{
  var baseUri = "$BASEURI/category";

  //get rate for each company id
  Future<dynamic> getRates(id) async {
    try {
      var response = await http
          .get(Uri.parse("$baseUri/getRate/$id"),
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