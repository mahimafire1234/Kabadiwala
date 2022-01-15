import 'dart:convert';

import 'package:http/http.dart' as http;

class BookingServices{
  static var baseUri = "http://10.0.2.2:5000/booking/";

  Future<String?> book(body, token) async {
    try {
      var response = await http.post(Uri.parse("$baseUri"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> approved(id, token) async {
    try {
      var response = await http.put(
        Uri.parse(baseUri + "approved/$id"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> declined(id, token) async {
    try {
      var response = await http.put(
        Uri.parse(baseUri + "declined/$id"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getApprovedOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "get_approved"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getDeclinedOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "get_decline"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getPendingOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "get_pending"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  //client side view appointments
  //view approved
  static Future<dynamic> viewApprovedOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "view_approved"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  //view declined
  static Future<dynamic> viewDeclinedOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "view_declined"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  //view pending
  static Future<dynamic> viewPendingOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "view_pending"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  //cancel
  static Future<String?> updateBooking(userid, bookingid, token, body) async {
    try {
      var response = await http.post(Uri.parse("${baseUri}updateBook/$userid/$bookingid"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: body);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

}
