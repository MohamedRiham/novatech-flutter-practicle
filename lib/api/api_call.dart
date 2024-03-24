import '../SharedPreferences/AddData.dart';
import '../database/database_manager.dart';
import 'dart:convert';

import '../models/api_data.dart';
import 'package:http/http.dart' as http;

class ApiCall {
AddData sp = new AddData();
  final DatabaseManager dbManager = new DatabaseManager();


  Future<void> getData() async {
final    String url = 'https://api.publicapis.org/entries';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    var jsonData = await jsonDecode(response.body);
  var firstEntry = jsonData['entries'][0];

  // Extract the value for the 'api' key
  String singleApiValue = firstEntry['API'];  
  if (response.statusCode == 200) {


    for (var element in jsonData['entries']) {


  ApiData apidata = ApiData.fromJson(element);

dbManager.insertData(apidata.toJson());

    }
      sp.insertData(singleApiValue);
} else {
print('data not inserted');
}
  }
}
