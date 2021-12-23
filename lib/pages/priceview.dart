import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PriceView extends StatefulWidget {
  const PriceView({Key? key}) : super(key: key);

  @override
  _PriceViewState createState() => _PriceViewState();
}

class _PriceViewState extends State<PriceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Company',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 600,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0077B6),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Row(
                        children: const [
                          Text(
                            'Item names',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                            child: Text(
                              'Price/kg',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: PhysicalModel(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        elevation: 5.0,
                        shadowColor: Color(0xff5a5a5a),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              Row(children: const [
                                Text("Plastic Bottle",
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 12,
                                      fontFamily: 'Rubik'),
                                ),
                                SizedBox(width: 10.0),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                                  child: Text("Rs.15",
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 12,
                                        fontFamily: 'Rubik'),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
