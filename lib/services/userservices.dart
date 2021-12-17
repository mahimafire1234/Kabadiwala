import 'package:http/http.dart' as http;

class UserServices{
  dynamic signup(body) async {
    try {
      var response = await http
          .post(Uri.parse("http://10.0.2.2:5000/user/register"), body: body);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

}