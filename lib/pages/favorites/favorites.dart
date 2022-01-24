import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';
import 'package:login_sprint1/pages/company/oneCompany.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class Favorites extends StatefulWidget {

  Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  //get favorites
  Future<List<FavoritesList>?> getFavorites() async{
    String id = await  MySharedPreferences.getLoginId!;

    var response = await http.get(Uri.parse("$BASEURI/favorites/getFavorites/$id"),
      headers: {
        'Content-type' : 'application/json',
        "Accept": "application/json",
      },
    );
    var jsonData = await jsonDecode(response.body);
    List<FavoritesList> favoritesData = [];
    var result= jsonData["data"][0]["company"];
    print(result);

    for(var u in result){
      FavoritesList user = FavoritesList(u["companyName"],u["companyID"],u["companyEmail"]);
      favoritesData.add(user);
    }
    print(favoritesData);
    return favoritesData;
  }

  //delete from favorites
  deleteFavorites(companyID) async{
    String id = await  MySharedPreferences.getLoginId!;
    try{
      var response = await http.delete(Uri.parse("$BASEURI/favorites/deleteFavorites/$id/$companyID"),
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("My Favorites",
                    style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize:30),),
                    FutureBuilder<List<FavoritesList>?>(
                      future: getFavorites(),
                      builder:  (context,  snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Nothing to show"),
                            ),
                          );
                        }else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount : snapshot.data?.length,
                            itemBuilder : (context, i){
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: PhysicalModel(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  elevation: 5.0,
                                  shadowColor: Color(0xff5a5a5a),
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        const SizedBox(height: 20.0),
                                        Row(
                                            children:[
                                              Image(
                                                image: AssetImage("assets/images/cycling.png"),
                                                width: 100,
                                                height: 100,
                                              ),
                                              SizedBox(width: 20.0),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![i].name,
                                                    style: TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 18,
                                                        fontFamily: 'Rubik'),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Text(snapshot.data![i].email,
                                                    style: TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 18,
                                                        fontFamily: 'Rubik'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.delete_rounded,
                                                      color: Colors.blue,
                                                      size: 30.0,
                                                      semanticLabel: "Icon",

                                                    ),
                                                    onTap: () async {
                                                      var companyID = snapshot.data![i].id;
                                                      var response = await deleteFavorites(companyID);
                                                      var res = json.decode(response);
                                                      final snackB = SnackBar(
                                                        duration: Duration(seconds: 5),
                                                        content: Text(res["message"]),
                                                        action: SnackBarAction(
                                                          label: 'Dismiss',
                                                          onPressed: () {},
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(context).showSnackBar(snackB);
                                                      Navigator.pushNamed(context, "/favorites");
                                                    },
                                                  )
                                                ],

                                              )



                                            ]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              ;
                            },
                          );
                        }
                      },
                    ),

                  ],
                ),
              ),

            ),
          ),
        )

    );
  }
}

class FavoritesList{
  final String name,id,email;
  FavoritesList(this.name,this.id,this.email);
}


