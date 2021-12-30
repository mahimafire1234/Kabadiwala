class SaveLocalData {
  static List<String> _mySavedData = [];

  static void savedData(dynamic anyData) {
    _mySavedData.add(anyData);
  }

  static List<String> get getSavedData => _mySavedData;
}
