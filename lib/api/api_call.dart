import '../SharedPreferences/AddData.dart';
import '../database/database_manager.dart';
import 'dart:convert';

import '../models/api_data.dart';
import 'package:http/http.dart' as http;

class ApiCall {
AddData sp = new AddData();
  final DatabaseManager dbManager = new DatabaseManager();

  // saving json data
  List<ApiData> saveddata = [];

  Future<void> getData() async {
    String url = 'https://api.publicapis.org/entries';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    var jsonData = jsonDecode(response.body);
  var firstEntry = jsonData['entries'][0];

  // Extract the value for the 'api' key
  String singleApiValue = firstEntry['API'];  

    jsonData['entries'].forEach((element) {
      // Handling null values using null-aware operators
      ApiData apidata = ApiData(
        api: element['API'] ?? '', // If 'API' is null, use an empty string
        description: element['Description'] ?? '', // If 'Description' is null, use an empty string
        auth: element['Auth'] ?? '', // If 'Auth' is null, use an empty string
        cors: element['Cors'] ?? '', // If 'Cors' is null, use an empty string
        link: element['Link'] ?? '', // If 'Link' is null, use an empty string
        category: element['Category'] ?? '', // If 'Category' is null, use an empty string
      );
      saveddata.add(apidata);
dbManager.insertData(apidata);
    });
      sp.insertData(singleApiValue);

  }
}