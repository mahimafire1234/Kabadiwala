import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:integration_test/integration_test.dart';
import "package:login_sprint1/main.dart" as app;
void main(){
  group("Login test", (){

    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    
    testWidgets("Login test", (tester) async{
      app.main();
      await tester.pumpAndSettle();

      final emailFormField = find.byKey(Key("myEmailKey"));
      final PasswordFormField = find.byKey(Key("myPasswordKey"));
      final loginButton = find.byType(ElevatedButton).first;

    //  enter input
      await tester.enterText(emailFormField, "kab123@gmail.com");
      await tester.enterText(PasswordFormField, "kab");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();
    });
  });
}