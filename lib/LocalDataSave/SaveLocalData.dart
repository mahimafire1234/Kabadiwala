class SaveLocalData {
  static List<String> _mySavedData = [];
  static List<dynamic> _list = [];
  static String? _bookingId;

  static void savedData(dynamic anyData) {
    _mySavedData.add(anyData);
  }

  static void saveConfirmBookingId(String id) {
    _bookingId = id;
  }

  static get getconfirmBookingId => _bookingId;

  static List<String> get getSavedData => _mySavedData;

  static void savedMyData(dynamic anyData) {
    print(anyData);
    _list = anyData;
  }

  static List<dynamic> get getMySavedData => _list;
}
