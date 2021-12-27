import 'package:flutter/material.dart';
import 'package:login_sprint1/pages/Constraints.dart';

class SetInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 100.0),
          child: Column(
            children: [
              const Text(
                kSetInformationTitle,
                style: kTextStyle,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              SizedBox(height: 20.0),
              Row(
                children: const [
                  Text(
                    "Company: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Rajiv karky",
                    style: TextStyle(fontSize: 16.0, color: Colors.redAccent),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              ColumnStart(),
              ColumnStart(),
              ColumnStart(),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnStart extends StatelessWidget {
  const ColumnStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      elevation: 8.0,
      child: TextField(),
    );
  }
}
