import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  // Private constructor
  DataProvider._();

  // Singleton instance variable
  static DataProvider? _instance;

  // Static factory method to get the singleton instance
  factory DataProvider() {
    // Create the instance if it doesn't exist
    _instance ??= DataProvider._();
    return _instance!;
  }
String api = '';
  String description = '';

  void modify(String newApi, String newDescription) {
api = newApi;
    description = newDescription;

    notifyListeners();
  }
}
