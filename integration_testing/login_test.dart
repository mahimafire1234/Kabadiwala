import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:integration_test/integration_test.dart';
import 'package:login_sprint1/pages/user/login.dart';
// import "package:login_sprint1/main.dart" as app;
void main(){
  group("Login test", (){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    
    testWidgets("Login test", (WidgetTester tester) async{
      LoginPage loginpage = new LoginPage();
      await tester.pumpWidget(MaterialApp(home: loginpage));

      final emailFormField = find.byKey(Key("myEmailKey"));
      print("here");
      final PasswordFormField = find.byKey(Key("myPasswordKey"));
      final loginButton = find.byType(ElevatedButton).first;

    //  enter input
      await tester.enterText(emailFormField, "kab@mm.com");
      await tester.enterText(PasswordFormField, "kab123");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();
    });
  });
}