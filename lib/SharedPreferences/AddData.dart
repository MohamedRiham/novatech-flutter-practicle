import 'package:shared_preferences/shared_preferences.dart';

class AddData {
  SharedPreferences? _prefs;

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void insertData(String data) async {
await initializeSharedPreferences();
    await _prefs!.setString('api', data);
print('data inserted');
  }

  Future<Map<String, String>> getData() async {
await initializeSharedPreferences();
    String? data = _prefs?.getString('api') ?? '';

    return {'api': data ?? ''};
  }
}//end class
