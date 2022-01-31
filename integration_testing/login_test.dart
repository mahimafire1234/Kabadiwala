import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:integration_test/integration_test.dart';
import 'package:login_sprint1/main.dart';
import 'package:login_sprint1/pages/user/login.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// import "package:login_sprint1/main.dart" as app;
void main(){
  group("Login tests ", (){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    
    testWidgets("Login test", (WidgetTester tester) async{
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(MyApp());

      final emailFormField = find.byType(TextFormField).first;
      final PasswordFormField =  find.byType(TextFormField).last;
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