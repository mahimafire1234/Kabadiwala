import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/rates/priceview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_sprint1/pages/ratings/Ratings.dart';
import 'package:login_sprint1/services/shared_preference.dart';

import '../booking/items.dart';

class oneCompany extends StatefulWidget {
  String companyID;
  oneCompany({required this.companyID});
  // const oneCompany({Key? key}) : super(key: key);

  @override
  _ShowOneState createState() => _ShowOneState(companyID);
}

class _ShowOneState extends State<oneCompany> {
  String companyID;
  String name = "";
  _ShowOneState(this.companyID);
  //get wala for one company info

  Future<List<OneCompany>>? getOneCompany() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:5000/user/showOne/$companyID"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    var deriveData = jsonData["user"];
    List<OneCompany> onecompanyList =[];
    OneCompany onecompany = OneCompany(deriveData["name"], deriveData["email"], deriveData["id"]);
    onecompanyList.add(onecompany);

    name = deriveData["name"];
    // // adding data to empty list
    return onecompanyList;
  }

  //get rating for company
  Future<num>? getRate() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:5000/rate/getRate/${companyID}"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    var deriveData = jsonData["data"]["rating"];
    // // adding data to empty list
    return deriveData;
  }

  //post function for favorites
  Future<dynamic>? addToFavorites() async{
    String id = await  MySharedPreferences.getLoginId!;
    print(id);

    try{
      var response = await http.post(Uri.parse("http://10.0.2.2:5000/favorites/addfavorites/$id/$companyID"),
        headers: {
          'Content-type' : 'application/json',
          "Accept": "application/json",
        },
      );
      return response.body;
    }catch(error){
      print(error);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Kabadiwala"),
            backgroundColor: Color(0xff0077B6)),
        body: SafeArea(
          child:SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 35,
            ),
            Center(
              child: Image(
                image: AssetImage("assets/images/cycling.png"),
                width: 200,
                height: 200,
              ),
            ),
            FutureBuilder<List<OneCompany>>(
              future: getOneCompany() ,
              builder:  (context,  snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("empty"),
                    ),
                  );
                }else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(snapshot.data![0].name,style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                        ),
                        Container(
                          child: Text(snapshot.data![0].email,style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20)),
                        )

                      ],
                    ),
                  );
                }
              },
            ),
            FutureBuilder<num>(
              future: getRate() ,
              builder:  (context,  snapshot) {
                if (snapshot.data == null) {
                  return RatingBar.builder(
                      initialRating: 0.0,
                      itemBuilder: (context,_) => Icon(Icons.star,color: Colors.amber,),
                      onRatingUpdate: (rating) {}
                  );
                }else {
                  return RatingBar.builder(
                    allowHalfRating: true,
                      initialRating: snapshot.data!.toDouble(),
                      itemBuilder: (context,_) => Icon(Icons.star,color: Colors.amber,),
                      onRatingUpdate: (rating) {}
                  );
                }
              },
            ),

           InkWell(
             child: Text("Rate Now",style: TextStyle(color: Colors.blue),),
             onTap:(){ Navigator.push(context, MaterialPageRoute(
               builder: (context) => RatingCompany(company_id: this.companyID,),
             ));},
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 119, 182)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 60.0, vertical: 19.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 0, 119, 182))))),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ItemsHire(id: this.companyID, name: this.name ),

                      ));
                    },
                    child: Text(
                      "Book Now",
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 119, 182)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 0, 119, 182))))),
                    onPressed: () async {
                      var response = await addToFavorites();
                      var res = json.decode(response);
                      print(res["success"]);
                      if (res["success"] == true) {
                        final snackB = SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text("Added To favorites successfully"),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackB);
                      }
                    },
                    child: Icon(
                      CupertinoIcons.heart_solid,
                      color: Colors.red,
                    ),
                  ),
                ),
              ]),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 0, 119, 182)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 118.0, vertical: 19.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Color.fromARGB(255, 0, 119, 182))))),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PriceView(company_id: companyID,)));              },
              child: Text(
                "See Pricings",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.orange, width: 2.0)),
                      prefixIcon: Icon(
                        CupertinoIcons.square_pencil,
                      ),
                      suffixIcon: Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.green,
                        size: 35.0,
                      ),
                      labelText: "Write a Review...",
                      contentPadding: EdgeInsets.only(left: 80.0)),
                ),
              ),
            ),
          ]),
        )));
  }
}
class OneCompany{
  final String name, email,id;
  OneCompany(this.name, this.email,this.id);
}
class Ratings{
  final double ratings;
  final String id;
  Ratings(this.ratings, this.id);
}
