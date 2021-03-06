import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';

class BookingServices {
  static var baseUri = "$BASEURI/booking/";

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

  Future<String?> updateBookingCompany(id, body, token) async {
    try {
      var response = await http.put(Uri.parse(baseUri + "update/$id"),
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

  static Future<dynamic> getPayTransition(usertype, id) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "get_payment/$usertype/$id/"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
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
      var response =
          await http.put(Uri.parse("${baseUri}updateBook/$userid/$bookingid"),
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

  static Future<String?> getAllbooking() async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "getAllBooking"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> approvedOrderRequest(id, token) async {
    try {
      var response = await http.put(
        Uri.parse(baseUri + "approvedOrderRequest/$id"),
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
}
