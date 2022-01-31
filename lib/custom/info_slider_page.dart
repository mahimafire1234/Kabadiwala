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
        title: "Great Discounts",
        description: "Best discounts on every single service we offer!",
        pathImage: "assets/images/img_1.png",
      ),
    );
    slides.add(
      new Slide(
        title: "World Travel",
        description:
            "Book tickets of any transportation and travel the world! ",
        pathImage: "assets/images/img_2.png",
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
                      height: 60,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 25),
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      currentSlide.pathImage.toString(),
                      matchTextDirection: true,
                      height: 60,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 25),
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
        style: TextStyle(color: Colors.green[700]),
      ),
      // renderNextBtn: Visibility(
      //   child: Text("next"),
      //   visible: false,
      // ),
      showNextBtn: false,

      renderDoneBtn: Text(
        "Done",
        style: TextStyle(color: Colors.red[700]),
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
