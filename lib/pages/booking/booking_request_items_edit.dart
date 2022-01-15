import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/company/oneCompany.dart';
import 'package:login_sprint1/pages/booking/set_information.dart';
import 'package:login_sprint1/pages/company/viewcompany.dart';
import 'package:login_sprint1/services/category_services.dart';

import 'booking_request_confirm.dart';
import 'items.dart';

class ItemsEdit extends StatefulWidget {
  final Object bookingData;
  final int total;
  const ItemsEdit({Key? key, required this.bookingData, required this.total}) : super(key: key);

  @override
  _ItemsEditState createState() => _ItemsEditState(bookingData: bookingData, total: total);
}

class _ItemsEditState extends State<ItemsEdit> {
  var bookingData;
  List<CategoryRate> data = [];
  int total;

  List<dynamic> previous = [];
  var items = [];
  var rates = [];
  var body = {};

  _ItemsEditState({required this.bookingData, required this.total});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF0077B6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: 400,
              height: 800,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(19),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Text(
                          'Items',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF0077B6),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text(
                            'User: ',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          Text(
                            bookingData["user"]["name"],
                            style: TextStyle(
                                color: Color(0xFFF2662A),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: const [
                            Text(
                              'Items',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              'Name',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 0, 35, 0),
                            child: Text(
                              'Rate(Rs.)',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          Text(
                            'Quantity',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Divider(color: Colors.black),
                      ),
                      ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: bookingData["items"].length,
                                  itemBuilder: (context, i){
                                    previous = bookingData["items"];

                                    if(rates.isEmpty){
                                      rates = List<int>.filled(bookingData["items"].length, 0, growable: true);
                                      for(int i=0; i<bookingData["items"].length; i++){
                                        var price =  int.parse(bookingData["items"]![i]["category_price"].toString()) ~/ int.parse(bookingData["items"]![i]["amount"].toString());
                                        rates[i] =  int.parse(price.toString());
                                      }
                                    }
                                    return  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${bookingData["items"]![i]["category"]}",
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Rubik'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(35, 0, 90, 0),
                                            child: Text(
                                              rates[i].toString(),
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Rubik'),
                                            ),
                                          ),
                                          ConstrainedBox(constraints: const BoxConstraints(
                                              maxWidth: 80.0,
                                              minWidth: 5.0,
                                              maxHeight: 20.0,
                                              minHeight: 18.0
                                          ),
                                              child: TextFormField(
                                                initialValue: bookingData["items"]![i]["amount"].toString(),
                                                onChanged: (input) {
                                                  var last = int.parse(previous[i]["category_price"].toString());
                                                  var data = 0;
                                                  if(input.isNotEmpty){
                                                    data = int.parse(input) * int.parse(rates[i].toString()) ;
                                                  }
                                                  setState(() => total = total - last + data);
                                                  previous[i]["amount"] = input;
                                                  previous[i]["category_price"] = data;

                                                  var itemData = {
                                                    "category": bookingData["items"]![i]["category"],
                                                    "amount": input.isNotEmpty ? input : "0",
                                                    "category_price":  input.isNotEmpty? data: "0"
                                                  };

                                                  bookingData["items"]![i] = itemData;
                                                  bookingData["total_price"] = total;
                                                },
                                              )),
                                        ],
                                      ),
                                    );

                                  }
                              )
                      ,
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Divider(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          Text(
                            'Total: ',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              total.toString(),
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFFFFFF),
                                  onPrimary: Color(0xFF0077B6),
                                )),
                            SizedBox(width: 10.0),
                            ElevatedButton(
                              onPressed: ()  {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => BookingRequestConfirm(data: bookingData),
                                ));
                              },
                              child: Text("Edit"),
                            )
                          ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


