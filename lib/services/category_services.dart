import 'package:http/http.dart' as http;

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

}