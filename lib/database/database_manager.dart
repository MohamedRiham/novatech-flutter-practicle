import '../models/api_data.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Database? _database;

  Future openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "api_data.db"),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE data (id INTEGER PRIMARY KEY AUTOINCREMENT, API TEXT, Description TEXT, Auth TEXT, Cors TEXT, Link TEXT, Category Text)",
        );
      },
    );
    return _database;
  }

  Future<int?> insertData(Map<String, dynamic> apidata) async {
    await openDb();
    await _database?.insert('data', apidata);

  }

  Future<List<ApiData>> getDataList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.rawQuery('SELECT * FROM data');
return maps.map((item) => ApiData.fromJson(item)).toList();
  }

  Future<List<ApiData>> getItemsSortedByCategory(String category) async {
    await openDb();

  
List<Map<String, dynamic>> maps =  await _database!.query('data', orderBy: 'Category', where: 'Category = ?', whereArgs: [category]);
return maps.map((item) => ApiData.fromJson(item)).toList();



 }

Future<void> deleteRow(String value) async {
    await openDb();

    await _database!.delete(
      'data',
      where: 'API = ?',
      whereArgs: [value],
    );
  }


Future<void> updateData(String? specificValue, String? newApi, String? newDescription) async {
  await openDb(); 

    await _database!.update(
      'data', 
      {
        'API': newApi,
        'Description': newDescription,

      }, 
      where: 'API = ?', 
      whereArgs: [specificValue], // Pass the specific value as a whereArgs parameter
    );

}

}

