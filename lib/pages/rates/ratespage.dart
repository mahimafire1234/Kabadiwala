import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_sprint1/pages/rates/insertrate.dart';
import 'package:login_sprint1/pages/rates/updateRate.dart';
import 'package:http/http.dart' as http;

class Rates extends StatefulWidget{
  String company_id;
  Rates({required this.company_id});
  // const Rates({Key ? key}) : super(key:key);

  @override
  _RatesState createState()=> _RatesState(company_id);
}

class _RatesState extends State<Rates>{
  String company_id;
  _RatesState(this.company_id);

  Widget buildNavigationButton () => FloatingActionButton(
    //onclick
    onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder:(context)=> InsertRate(company_id:company_id)));
    },
    child: Text("+",style:TextStyle(fontWeight: FontWeight.w200)),
    backgroundColor: Color(0xff0077B6),
  );

  //variable for company id
  // var company_id = id;

  //get response
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
        Category_Rate category_rates = Category_Rate(item["price"],item["category"],item["_id"]);
        category_rate.add(category_rates);
      }
      return category_rate;
    }
    catch(error){
      print(error);
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getRate(company_id);
  // }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
          title: Text("Kabadiwala"),
          backgroundColor: Color(0xff0077B6)),
      body:
      SafeArea(
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
                              child: Text("You havenot added any price rates"),
                            ),
                          );
                        }else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount : snapshot.data?.length,
                            itemBuilder : (context, i){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      UpdateRate(company_id: company_id,objectID:snapshot.data![i].objectID,priceOld:snapshot.data![i].price)));
                                  },
                              child:
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
                              ))
                              ;
                            },
                          );
                        }
                      },
                    ),


                  ]),),),),]),),
      floatingActionButton: buildNavigationButton(),
    )
    ;}

}

//class Category rate for get response
class Category_Rate{
  final String price, category_rate,objectID;
  Category_Rate(this.price, this.category_rate,this.objectID);
}
