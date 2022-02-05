import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home"),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.arrow_left, color: Colors.white),
          ),
          backgroundColor: Color(0xff0077B6)),
        body: Container(
            child: Stack(
          children: <Widget>[
            //stack overlaps widgets
            Opacity(
              //semi red clippath with more height and with 0.5 opacity
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(), //set our custom wave clipper
                child: Container(
                  color: Color(0xFF96D3F3),
                  height: 120,
                ),
              ),
            ),

            ClipPath(
              //upper clippath with less height
              clipper: WaveClipper(), //set our custom wave clipper.
              child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  color: Color(0xFF0077B6),
                  height: 90,
                  alignment: Alignment.center,
                  ),
            ),
             Column(
               children:  [
                 const Padding(
                   padding: EdgeInsets.fromLTRB(0, 120, 0, 10),
                   child: Text("About",
                       style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                           fontFamily: 'Rubik'
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                     text: const TextSpan(children: [
                       TextSpan(
                           text: 'Kabadiwala is an app that helps people to earn money by selling the waste products such as paper, bottles, and plastics. People dump the waste materials in the local garbage sites and in the road near the houses. The municipality collects the waste from every household according to the schedule. The dumps remain uncollected in most of the localities, and they remain on the road for days, increasing pollution and making the environment polluted, stinking and difficult to breathe. The majority of people burn their trash, which pollutes the environment and has a direct impact on humidity. Rag Pickers are not easily found these days as they have to roam around alleys screaming for plastics and used products. ',
                           style: TextStyle(
                           color: Colors.black, )
                          ),
                       TextSpan(
                           text: 'The main goal of developing the Kabadiwala app is to recycle, reuse and reduce waste by selling the waste materials to the Rag Pickers and earning money out of the waste materials. The deployment of the app will help in creating a positive impact on our environment. Not only the rag pickers but the municipalities are also benefited from the application as they do not have to visit the localities time and again and manage the wastes. ',
                           style: TextStyle(
                                color: Colors.black)
                       ),
                     ]),
                 ),
                  ),
               ],
             )
          ],

        ),
        ),



    );
  }
}


class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;


  }
}
