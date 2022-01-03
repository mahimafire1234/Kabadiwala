import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PriceView extends StatefulWidget {
  // const PriceView({Key? key}) : super(key: key);
  String company_id;
  PriceView({required this.company_id});
  @override
  _PriceViewState createState() => _PriceViewState(company_id);
}

class _PriceViewState extends State<PriceView> {
  String company_id;
  _PriceViewState(this.company_id);

  // /get response
  Future<List<Category_Rate>?> getRate(id) async {
    try{
      //  url
      final fetchUrl = "http://10.0.2.2:5000/category/getRate/${id}";
      var response = await http.get(Uri.parse(fetchUrl));
      var jsonData = jsonDecode(response.body);
      var result= jsonData["data"][0]["category_rate"];
      // print(result);

      //list of category rate an empty list
      List<Category_Rate> category_rate = [];

      for(var item in result){
        Category_Rate category_rates = Category_Rate(item["price"],item["category"]);
        category_rate.add(category_rates);
      }
      return category_rate;
    }
    catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body:       SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Rate list',
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
              height: 400,
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
                      FutureBuilder<List<Category_Rate>?>(
                        future: getRate(company_id),
                        builder:  (context,  snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text("Add rates"),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10.0),
                                          Row(
                                              children:[
                                                Text(snapshot.data![i].category_rate,
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 18,
                                                      fontFamily: 'Rubik'),
                                                ),
                                                SizedBox(width: 10.0),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                                                  child: Text(snapshot.data![i].price,
                                                    style: TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 18,
                                                        fontFamily: 'Rubik'),
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(height: 10.0),
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


                    ]),),),),]),),

    );
  }
}
//class Category rate for get response
class Category_Rate{
  final String price, category_rate;
  Category_Rate(this.price, this.category_rate);}