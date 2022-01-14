import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/rates/ratespage.dart';

class UpdateRate extends StatefulWidget {
  String company_id;
  String objectID;
  String priceOld;
  UpdateRate({required this.company_id,required this.objectID,required this.priceOld});
  // const InsertRate({Key? key}) : super(key: key);

  @override
  _UpdateRateState createState() => _UpdateRateState(company_id,objectID,priceOld);
}

class _UpdateRateState extends State<UpdateRate> {
  String company_id;
  String objectID;
  String priceOld;
  _UpdateRateState(this.company_id,this.objectID,this.priceOld);

  //backend ma insert ko lagi
  String price = "";
  // String userID = company_id;
  postData() async {
    try {
      var data = {"price":price};
      var body = await json.encode(data);
      print(body);
      var response =
      await http.put(Uri.parse("http://10.0.2.2:5000/category/updateRate/${company_id}/${objectID}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: body);
      print(body);
      return response.body;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(company_id);
    print(objectID);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Update Pricing',
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
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                elevation: 5.0,
                shadowColor: const Color(0xff2a2a2a),
                child: TextFormField(
                  initialValue: priceOld,
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
                      if(res["success"] == true){
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
