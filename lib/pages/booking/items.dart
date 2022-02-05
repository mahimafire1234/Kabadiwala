import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login_sprint1/pages/company/oneCompany.dart';
import 'package:login_sprint1/pages/booking/set_information.dart';
import 'package:login_sprint1/pages/company/viewcompany.dart';
import 'package:login_sprint1/services/category_services.dart';

class ItemsHire extends StatefulWidget {
  final id;
  final name;
  const ItemsHire({Key? key, required this.id, required this.name}) : super(key: key);



  @override
  _ItemsHireState createState() => _ItemsHireState(id: id, name: name);
}

class _ItemsHireState extends State<ItemsHire> {
  String id;
  String name;
  List<CategoryRate> data = [];
  int total = 0;

  List<int> previous = [];
  var items = [];
  var body = {};

  TextEditingController locationinput = TextEditingController();

  _ItemsHireState({required this.id, required this.name });

  Future<List<CategoryRate>> getRates() async {
    try {
      var categoryServices = CategoryServices();
      var response = await categoryServices.getRates(id);
      var resBody = json.decode(response);
      var categoryRate = resBody["data"][0]["category_rate"];
      List<CategoryRate> categoryRateList = [];
      for(int i = 0; i<categoryRate.length; i++ ){
        var cr = categoryRate[i];
        categoryRateList.add(
          CategoryRate(cr["_id"], cr["category"], cr["price"])
        );
      }
      data = categoryRateList;
      return categoryRateList;
    } catch (e) {
      print(e);
    }
    return [];
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          title: Text("Company"),
          backgroundColor: Color(0xff0077B6)
      ),
      backgroundColor: Color(0xFF0077B6),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    mainAxisSize: MainAxisSize.min,
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
                        children:  [
                          Text(
                            'Company: ',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          Text(
                            name,
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
                      FutureBuilder<List<CategoryRate>?>(

                        future: getRates(),
                          builder: (context, snapshot) {
                            if(snapshot.data == null){
                              return Container(
                                  child: Center(
                                    child: Text("Loading.."),
                                  )
                              );
                            }else{
                              if(previous.isEmpty){
                                previous = List<int>.filled(data.length, 0, growable: true);
                              }

                              if(items.isEmpty){
                                items = List<dynamic>.filled(data.length, {}, growable: true);

                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                  itemBuilder: (context, i){
                                  return  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${snapshot.data![i].category}",
                                          style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Rubik'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(35, 0, 90, 0),
                                          child: Text(
                                            snapshot.data![i].price,
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Rubik'),
                                          ),
                                        ),
                                        ConstrainedBox(constraints: const BoxConstraints(
                                          maxWidth: 80.0,
                                          minWidth: 5.0,
                                          maxHeight: 20.0,
                                          minHeight: 18.0
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          initialValue: '0',
                                          onChanged: (input) {
                                            var last = previous[i];
                                            var data = 0;
                                            if(input.isNotEmpty) data = int.parse(input) * int.parse(snapshot.data![i].price);
                                            setState(() => total = total - last + data);
                                            previous[i] = data;

                                            var itemData = {
                                              "category": snapshot.data![i].category,
                                              "amount": input.isNotEmpty ? input : "0",
                                              "category_price": input.isNotEmpty ? data.toString() : "0"
                                            };

                                            items[i] = itemData;


                                          },
                                        )),
                                      ],
                                    ),
                                  );

                                  }
                              );
                            }

                          }
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Divider(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
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
                              total.toString(),
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
                              onPressed: () {
                                print(items);
                                var filteredItems = [];
                                for(int i = 0; i< items.length; i++ ){
                                  if(items[i].toString() != "{}"){
                                    filteredItems.add(items[i]);
                                  }
                                }
                                body = {
                                  "items": filteredItems,
                                  "total_price": total
                                };

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SetInformation(id: this.id, name: this.name, body: this.body ),
                                ));
                              },
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
      ),
    );
  }
}


class CategoryRate{
  final String _id, category, price;
  CategoryRate(this._id, this.category, this.price);

  getId() {
    return _id;
  }

  factory CategoryRate.fromJson(dynamic data){
    return CategoryRate(data['_id'] as String, data['category'] as String, data['price'] as String);
  }

}

