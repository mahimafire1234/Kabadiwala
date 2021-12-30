import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Scoreboard",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: 'Rubik')),
            Text("This week",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 182, 18),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Rubik')),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("41",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 214, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(height: 5.0),
                  Text("Highest",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                ]),
                Column(children: [
                  Text("29",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 172, 47),
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  Text("Your points",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                ]),
                Column(children: const [
                  Text("10",
                      style: TextStyle(
                          color: Color.fromARGB(255, 235, 11, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  Text("Average",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                ]),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(25.0),
                padding: EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 240, 240, 240),
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                )),
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 2.0,
                  crossAxisCount: 2,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        right: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      )),
                      child: const Option(
                          image: "assets/icons/garbage-truck.png",
                          text: "Order a \n pickup"),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          left: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        )),
                        child: Option(
                            image: "assets/icons/list.png",
                            text: "Scoreboard")),
                    GestureDetector(
                        onTap: (){Navigator.pushNamed(context, "/viewcompany");},
                      child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                right: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              )),
                          child: Option(image: "assets/icons/delivery.png", text: "Vendors"),
                    )

                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            left: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          )),
                      child:  Option(image: "assets/icons/group.png", text: "Forum"),
                    )
                  ],
                )),
          ],
        ),
      )
    ))

    );
  }
}

class Option extends StatefulWidget {
  final String? image;
  final String? text;

  const Option({Key? key, this.image, this.text}) : super(key: key);

  @override
  _OptionState createState() =>
      _OptionState(image: this.image, text: this.text);
}

class _OptionState extends State<Option> {
  String? image;
  String? text;

  _OptionState({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      Image.asset("${this.image}", width: 50),
      SizedBox(width: 15.0),
      Text("${this.text}", overflow: TextOverflow.clip)
    ]);
  }
}
