import 'package:flutter/material.dart';

class ButtonAsWidget extends MaterialButton {
  final onClick;
  final buttonText;
  final buttonColor;
  const ButtonAsWidget(
      {@required this.buttonColor,
      @required this.onClick,
      @required this.buttonText})
      : super(onPressed: onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: RawMaterialButton(
        onPressed: onClick,
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 20.0,
              letterSpacing: 2.0,
              fontFamily: 'Rubik-Bold',
              fontStyle: FontStyle.normal),
        ),
      ),
      height: 65.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 7.0), //(x,y)
              blurRadius: 4.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
