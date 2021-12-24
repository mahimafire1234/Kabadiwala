import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dropdown/awesome_dropdown.dart';

class InsertRate extends StatefulWidget {
  const InsertRate({Key? key}) : super(key: key);

  @override
  _InsertRateState createState() => _InsertRateState();
}

class _InsertRateState extends State<InsertRate> {
  final List<String> _list = ['Choose a category','Bottle','Plastic', 'Glass' ];
  //backend ma insert ko lagi
  String price = "";
  String category = "plastic";
  String userID ="1";
  var rate = [{"price":"200","category":"category"}, {"price":"200","category":"category"}];

  postData() async{
    try{
      var data ={
        "userID": userID,
        "category_rate": rate
      };
      var body = await json.encode(data);
      print(body);
      var response = await http.post(
          Uri.parse("http://10.0.2.2:5000/category/insertRate"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          },
          body: body);
      print(body);
      return response.body;
    }
    catch(error){
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
                child: Text('Set Pricing',
                  style: TextStyle(
                    color: Color(0xFF0077B6),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik'
                  ),
                ),
              ),

              const Text('Set your rate here',
                style: TextStyle(
                    color: Color(0xFF5F5F5F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik'
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AwesomeDropDown(
                    dropDownList: _list,
                    numOfListItemToShow: 3,
                    elevation: 3,
                    padding: 10,
                    dropDownIcon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    dropDownListTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,

                    ),
                    selectedItemTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,

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
                    onChanged: (val){
                        setState(() =>{
                          price = val.toString()
                        });

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
                        print(response);
                        // var res = json.decode(response);
                        // print("inserted");

                    },
                    child: const Text("Set Rate", style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),),
                      style: ButtonStyle(

                        shadowColor: MaterialStateProperty.all(const Color.fromARGB(255 ,2, 7, 153)),
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                              255, 0, 119, 182)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)

                              )
                          )
                      )


                  ),
                ),
              )
            ],
          ),

      ),
    );
  }
}
