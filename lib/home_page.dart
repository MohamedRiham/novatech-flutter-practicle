import 'provider/data.dart';

import 'package:provider/provider.dart';

import 'operations.dart';
import 'SharedPreferences/AddData.dart';
import '../models/api_data.dart';
import 'package:flutter/material.dart';
import 'api/api_call.dart';
import 'database/database_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

// initializing the list with the categories to sort
  var categories = ["Animals", "Business", "Cryptocurrency", "Books", "Development", "Environment", "Finance"];
//initializing the ApiCall class
  ApiCall apicall = ApiCall();
//initializing the model class
  List<ApiData> apidata = [];
//initializing the database manager class
  final DatabaseManager dbManager = new DatabaseManager();
//initializing the shared preferences class
  AddData sp = new AddData();

//dataList variable holds all the data which fetched from the sqflite database
  List<ApiData> dataList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    Map<String, String> result = await sp.getData();
    if (result['api']!.isEmpty) {
      print('sp is empty');
      await apicall.getData();
      setState(() {
        apidata = apicall.saveddata;
      });
    } else {
      print('sp is not empty');
    }
    dataList = await dbManager.getDataList();
    setState(() {});

  }

  // Method to sort data based on selected category
  Future<void> sortDataByCategory(String category) async {
    final List<Map<String, dynamic>> items = await dbManager.getItemsSortedByCategory(category);
    setState(() {
      dataList = items.map((item) => ApiData.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await sortDataByCategory(categories[index]); // Sort data when category tapped
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(categories[index]),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
        onTap: () async {
context.read<DataProvider>().modify(dataList[index].api, dataList[index].description);
 Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => Operations()),
);    
        },
  title: Text(
    dataList[index].api,
    style: TextStyle(color: Colors.white), 
  ),
                  subtitle: Text(
dataList[index].description,
    style: TextStyle(color: Colors.white), 
),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}