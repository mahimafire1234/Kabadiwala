import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'my_router.dart';

class IntroSliderPage extends StatefulWidget {
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // slides.add(
    //   new Slide(
    //     title: "Hello Food!",
    //     description:
    //         "The easiest way to order food from your favorite restaurant!",
    //     pathImage: "assets/images/hamburger.png",
    //   ),
    // );
    slides.add(
      new Slide(
        title: "Sell Your Bottles",
        description: "We all have left over bottles from dashain and tihar."
            " Sell all your bottles plastic and glass to our Kabadi misters in a tap of your screen",
        pathImage: "assets/images/img.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Sell Your Papers",
        description:
            "We all have our school books .Sell all your books in a tap of your screen",
        pathImage: "assets/images/img_1.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Find Kawadiwalas",
        description:
            "Find hundreds of kabadi walas with different selling rates."
            " Negotiate with them and sell all your unwanted good in one tap",
        pathImage: "assets/images/img_2.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Recycle Reuse Reduce",
        description:
            " Learn about the three R’s from our blogs written by users. You can also share your ideas and experiences through our blogs",
        pathImage: "assets/images/img_1.png",
      ),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      if (i == 0) {
        Slide currentSlide = slides[i];
        tabs.add(
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.only(bottom: 160, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      currentSlide.pathImage.toString(),
                      matchTextDirection: true,
                      height: 200,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      currentSlide.description.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 20,
                      right: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (i == 1) {
        Slide currentSlide = slides[i];
        tabs.add(
          Container(
            // color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.only(bottom: 160, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.white,
                    // ),
                    child: Image.asset(
                      currentSlide.pathImage.toString(),
                      matchTextDirection: true,
                      height: 150,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      currentSlide.description.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 20,
                      right: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (i == 2) {
        Slide currentSlide = slides[i];
        tabs.add(
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.only(bottom: 160, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.white,
                    // ),
                    child: Image.asset(
                      currentSlide.pathImage.toString(),
                      matchTextDirection: true,
                      height: 150,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      currentSlide.description.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 20,
                      right: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (i == 3) {
        Slide currentSlide = slides[i];
        tabs.add(
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.only(bottom: 160, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.white,
                    // ),
                    child: Image.asset(
                      currentSlide.pathImage.toString(),
                      matchTextDirection: true,
                      height: 150,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      currentSlide.description.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                  ),
                  Container(
                    height: 105,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 120.0, vertical: 12.0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: const Color(0xff0077B6),
      renderSkipBtn: Text(
        "Skip",
        style: TextStyle(color: Colors.white, fontSize: 25.0),
      ),
      renderNextBtn: Text(
        "Next",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      // renderNextBtn: Visibility(
      //   child: Text("next"),
      //   visible: false,
      // ),
      // showNextBtn: false,

      renderDoneBtn: Text(
        "Done",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      colorActiveDot: Colors.white,
      sizeDot: 8.0,
      slides: this.slides,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      colorDot: Colors.white,
      listCustomTabs: this.renderListCustomTabs(),
      scrollPhysics: BouncingScrollPhysics(),
      onDonePress: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyRoute(),
        ),
      ),
    );
  }
}
