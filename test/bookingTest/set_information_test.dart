import 'package:flutter_test/flutter_test.dart';
import 'package:login_sprint1/LocalDataSave/SaveLocalData.dart';

void main() {
  test("set information ", () {
    SaveLocalData.savedData("rajiv");
    var getValue = SaveLocalData.getSavedData[0];
    var expected = "rajiv";
    expect(expected, getValue);
  });
}
