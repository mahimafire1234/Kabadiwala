import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/pages/ratespage.dart';

void main() {
  test("get rates list test", () async {
    Rates ratespage = Rates(company_id: '1',);
    var data = await ratespage.company_id;
    var expected = true;
    var actual = data!.isNotEmpty  ;
    expect(expected, actual);
  });
}