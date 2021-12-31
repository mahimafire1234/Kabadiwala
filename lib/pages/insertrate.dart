import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/ratespage.dart';

class InsertRate extends StatefulWidget {
  String company_id;
  InsertRate({required this.company_id});
  // const InsertRate({Key? key}) : super(key: key);

  @override
  _InsertRateState createState() => _InsertRateState(company_id);
}

class _InsertRateState extends State<InsertRate> {
  String company_id;
  _InsertRateState(this.company_id);

  final List<String> category_list = ['Bottle', 'Plastic', 'Glass'];
  String? _selectedCategory;

  //backend ma insert ko lagi
  String price = "";
  String category = "";
  // String userID = company_id;


  postData() async {
    try {
      var rate = [
        {"price": price, "category": _selectedCategory}
      ];
      var data = {"userID": company_id, "category_rate": rate};
      var body = await json.encode(data);
      print(body);
      var response =
      await http.post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: body);
      print(body);
      return response.body;
    } catch (error) {
      print("error");
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Set Pricing',
                style: TextStyle(
                    color: Color(0xFF0077B6),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik'),
              ),
            ),
            const Text(
              'Set your rate here',
              style: TextStyle(
                  color: Color(0xFF5F5F5F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(45),
                color: Colors.white,
                elevation: 5.0,
                shadowColor: const Color(0xff2a2a2a),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      contentPadding: EdgeInsets.only(left: 20.0)),
                  hint: Text('Choose a category'),
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue as String;
                      print("sc");
                      print(_selectedCategory);
                    });
                  },
                  items: category_list.map((String value1) {
                    return DropdownMenuItem<String>(
                      value: value1,
                      child: new Text(value1),
                    );
                  }).toList(),
                  isDense: true,
                  isExpanded: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                elevation: 5.0,
                shadowColor: const Color(0xff2a2a2a),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      prefixIcon: Icon(
                        CupertinoIcons.money_dollar,
                        color: Color(0xFF000000),
                      ),
                      labelText: "Enter the rate",
                      contentPadding: EdgeInsets.only(left: 10.0)),
                  onChanged: (val) {
                    setState(() => {price = val.toString()});
                    print(price);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 350,
                height: 45,
                child: ElevatedButton(
                    onPressed: () async {
                      var response = await postData();
                      var res = json.decode(response);
                      print(res["success"]);
                      final snackB = SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text(res["message"]),
                        action: SnackBarAction(
                          label: 'Dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackB);
                      if(res["success"] == "true"){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=> Rates(company_id: company_id,)));
                      }
                    },
                    child: const Text(
                      "Set Rate",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 2, 7, 153)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 119, 182)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(25.0))))),
              ),
            )
          ],
        ),
      ),
    );
  }
}