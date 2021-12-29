import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/oneCompany.dart';

class ItemsHire extends StatefulWidget {
  const ItemsHire({Key? key}) : super(key: key);

  @override
  _ItemsHireState createState() => _ItemsHireState();
}

class _ItemsHireState extends State<ItemsHire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0077B6),
      body: SafeArea(
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
                      children: const [
                        Text(
                          'Company: ',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                        Text(
                          '<Company Name>',
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: const [
                          Text(
                            'Plastic Bottle',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Rubik'),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(35, 0, 90, 0),
                            child: Text(
                              '15/unit',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Rubik'),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Divider(color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
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
                            '0',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Add Schedule",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(6),
                                shadowColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 2, 7, 153)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 0, 119, 182)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
