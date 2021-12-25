import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/pages/viewcompany.dart';

void main() {
  test("get company list test", () async {
    ViewCompany viewCompany = const ViewCompany();
    var data = await viewCompany.getUserData();
    var expected = true;
    var actual = data!.isNotEmpty  ;
    expect(expected, actual);
  });
}