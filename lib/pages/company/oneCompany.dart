import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/rates/priceview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_sprint1/pages/ratings/Ratings.dart';
import 'package:login_sprint1/services/shared_preference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constraints/constraints.dart';
import '../booking/items.dart';

class oneCompany extends StatefulWidget {
  String companyID;

  oneCompany({required this.companyID});

  var reviewController = TextEditingController();

  // const oneCompany({Key? key}) : super(key: key);

  @override
  _ShowOneState createState() => _ShowOneState(companyID);
}

class _ShowOneState extends State<oneCompany> {
  String companyID;
  String name = "";
  String phone = "";
  String image = "";
  String review = "";
  _ShowOneState(this.companyID);
  //get wala for one company info

  @override
  void initState() {
    super.initState();

    getOneCompany();
  }

  Future<List<OneCompany>>? getOneCompany() async {
    var response = await http.get(Uri.parse("$BASEURI/user/showOne/${companyID}"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    var deriveData = jsonData["user"];
    List<OneCompany> onecompanyList =[];
    OneCompany onecompany = OneCompany(deriveData["name"], deriveData["email"], deriveData["id"], deriveData["phone"]);
    onecompanyList.add(onecompany);

    name = deriveData["name"];
    phone = deriveData["phone"];

    setState(() {
      image = deriveData["image"];
    });
    // // adding data to empty list
    return onecompanyList;
  }

  //get rating for company
  Future<num>? getRate() async {
    var response = await http.get(Uri.parse("$BASEURI/rate/getRate/${companyID}"),
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
      var response = await http.post(Uri.parse("$BASEURI/favorites/addfavorites/$id/$companyID"),
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
  //post function for review
  Future<dynamic>? insertReview() async {
    String id = await MySharedPreferences.getLoginId!;
    print(id);

    try {
      var body = {
        "review": widget.reviewController.text
      };
      var response = await http.post(
          Uri.parse("$BASEURI/review/insertReview/${id}/${companyID}"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: json.encode(body)
      );
      return response.body;
    } catch (error) {
      print(error);
    }
  }

  //get function for review
  Future<List<dynamic>?> getReview() async {
    List<dynamic> reviewList = [];
    try {
      var response = await http.get(
        Uri.parse("$BASEURI/review/getReview/${companyID}"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
      var data = jsonDecode(response.body);
      if (data["success"] == true) {
        var items = data["data"];
        for (dynamic i in items!) {
          reviewList.add(i);
        }
      }else {
        print("error");
      }
    } on Exception {
      Exception("Error");
    }
    return reviewList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("View Companies"),
            leading: TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/viewcompany"));
              },
              child: Icon(
                  CupertinoIcons.arrow_left,
                color: Colors.white
              ),
            ),
            backgroundColor: Color(0xff0077B6)),
        body: SafeArea(
            child:SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: this.image == null || this.image == "" ? Image(
                    image: AssetImage("assets/images/cycling.png"),
                    width: 200,
                    height: 200,
                  ) : Image.network(
                      "$BASEURI/${this.image}",
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
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.book),
                            SizedBox(width: 5),
                            Text(
                              "Book Now",
                            ),
                          ],
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

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Color.fromARGB(255, 0, 119, 182)),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 90.0, vertical: 19.0)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 0, 119, 182))))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PriceView(company_id: companyID,)));              },
                        child: Row(
                          children: [
                            Image.asset(
                                "assets/icons/hand.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              "See Pricings",
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Color.fromARGB(255,50,205,50)),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(255, 0, 119, 182))))),
                          onPressed: () async {
                            //indirect phone call
                            launch('tel://$phone');
                            //direct phone call
                            //await FlutterPhoneDirectCaller.callNumber(phone);
                          },
                          child:
                          Icon(
                            CupertinoIcons.phone_solid,
                            color: Colors.white,
                      )
                      ),
                    )
                  ],

                ),
                //review part
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Center(
                    child: TextFormField(
                      controller: widget.reviewController,
                      decoration: InputDecoration(
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.orange, width: 2.0)),
                          prefixIcon: Icon(
                            CupertinoIcons.square_pencil,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.check, size: 25.0, color: Colors
                                  .green),
                              onPressed: () async {
                                //insert review
                                var response = await insertReview();
                                widget.reviewController.clear();
                                var res = json.decode(response);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        super.widget));
                                final snackB = SnackBar(
                                  duration:
                                  Duration(seconds: 4),
                                  content:
                                  Text(res["message"]),
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              super.widget));
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackB);
                              }),
                          labelText: "Write a Review...",
                          contentPadding: EdgeInsets.only(left: 80.0)),
                    ),
                  ),
                ),
                //get review
                FutureBuilder<List<dynamic>?>(
                    future: getReview(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("No Reviews yet"),
                          ),
                        );
                      }else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: PhysicalModel(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    elevation: 10.0,
                                    shadowColor: Color(0xff000f61),
                                    child: ListTile(
                                        tileColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                        ),
                                        title: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data![i]["user"]["name"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  Row(children: [
                                                    Text(snapshot
                                                        .data![i]["review"]),
                                                    const SizedBox(width: 10.0),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                          ],

                                        ))),
                              );
                            });
                      };
                    })
              ]),
            )));
  }
}
class OneCompany{
  final String name, email,id, phone;
  OneCompany(this.name, this.email,this.id, this.phone);
}
class Ratings{
  final double ratings;
  final String id;
  Ratings(this.ratings, this.id);
}