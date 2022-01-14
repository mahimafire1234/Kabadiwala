import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/pages/user/login.dart';

void main() {
  test("Test for user login", () async* {
    LoginPage loginPage = LoginPage();
    var actual = await loginPage.login(
        loginEmail: "test12567@gmail.com", loginPassword: "test");
    expect(actual, 200);
  });
}
