import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/pages/login.dart';

void main() {
  test("login ko test", () async* {
    LoginPage loginPage = LoginPage();
    var actual = await loginPage.login(
        loginEmail: "rajivkarky15@gmail.com", loginPassword: "hi");
    expect(actual, 200);
  });
}
