import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "";
  String email = "";
  String number = "";
  String type = "";
  String password = "";

  postData() async{
    print("clicked");
    try{
      var body = {
        "name": name,
        "email": email,
        "number": number,
        "type": type,
        "password": password
      };
      var response = await http.post(
          Uri.parse("http://10.0.2.2:5000/user/register"),
          body: body
      );
      print(response.body);
    }catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 32
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Text('User Type:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(children: [

                        Radio(
                            value: "company",
                            groupValue: type,
                            onChanged: (value) {
                              setState(() {
                                  type = value.toString();
                        });
                            }),
                        Text("Company"),
                        Radio(
                            value: "normal",
                            groupValue: type,
                            onChanged: (value) {
                              setState(() {
                                type = value.toString();
                              });
                            }),
                        Text("Normal User"),
                      ])
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: TextField(
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                              prefixIcon: Icon(
                                CupertinoIcons.profile_circled,
                                color: Color(0xFF000000),
                              ),
                              labelText: "Enter Name",
                              contentPadding: EdgeInsets.only(left: 80.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: TextField(
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                              prefixIcon: Icon(
                                CupertinoIcons.envelope,
                                color: Color(0xFF000000),
                              ),
                              labelText: "Enter email",
                              contentPadding: EdgeInsets.only(left: 80.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: TextField(
                          onChanged: (val) {
                            setState(() => number = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                              prefixIcon: Icon(
                                CupertinoIcons.rectangle_stack_person_crop,
                                color: Color(0xFF000000),
                              ),
                              labelText: "Enter number",
                              contentPadding: EdgeInsets.only(left: 80.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: TextField(
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                              prefixIcon: Icon(
                                CupertinoIcons.lock,
                                color: Color(0xFF000000),
                              ),
                              suffixIcon: Icon(Icons.visibility_off),
                              labelText: "Enter Password",
                              contentPadding: EdgeInsets.only(left: 80.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: TextField(
                          obscureText: true,
                          onChanged: (val) {

                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                              prefixIcon: Icon(
                                CupertinoIcons.lock,
                                color: Color(0xFF000000),
                              ),
                              suffixIcon: Icon(Icons.visibility_off),
                              labelText: "Confirm Password",
                              contentPadding: EdgeInsets.only(left: 80.0)),
                        ),
                      ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: postData,
                          child: Text("Sign up")
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }
}


