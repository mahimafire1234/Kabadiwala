import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_sprint1/pages/company/viewcompany.dart';

class RatingCompany extends StatefulWidget {
  const RatingCompany({Key? key}) :super(key: key);

  @override
  _RatingCompanyState createState() => _RatingCompanyState();

}

class _RatingCompanyState extends State<RatingCompany>{

  int rating = 0;

  //sending ratings to backend
  sendRatings() async {
    var data = {"rating":this.rating};
    var body = await json.encode(data);
    String company_id = "61d96a36687290929a25f3c9";
    try{
      var response = await http.post(Uri.parse("http://10.0.2.2:5000/rate/giveRate/${company_id}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: body);
      return response.body;
    }
    catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF0077B6),
      body: Center(
        child: Container(
          width: 400,
          height: 500,
          padding: new EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
              children: <Widget>
              [
                ListTile(
                  title: Text(
                      "Rate the company",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Image(
                    image: AssetImage("assets/images/cycling.png"),
                    width: 200,
                    height: 100,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Company name",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                RatingBar.builder(
                  initialRating: this.rating.toDouble(),
                    itemBuilder: (context,_) => Icon(Icons.star,color: Colors.amber,),
                    minRating: 0,
                    updateOnDrag: true,
                    onRatingUpdate: (rating) {
                      setState(() {
                        this.rating = rating.toInt();
                      });
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () async {
                          print(this.rating);
                          var response = await sendRatings();
                          var res = json.decode(response);
                          print(res["success"]);
                          },
                        child: const Text(
                          "Done",
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
                                Color(0xFF06d6a0)),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(25.0))))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () async {

                          setState(() {
                            this.rating=0;
                          });
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewCompany(),

                          ));

                        },
                        child: const Text(
                          "Cancel",
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
                                Color(0xFFE61414)),
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

        ),
      ),
    );
  }

}