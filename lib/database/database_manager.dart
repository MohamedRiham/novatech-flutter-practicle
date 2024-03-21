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
          "CREATE TABLE data (id INTEGER PRIMARY KEY AUTOINCREMENT, api TEXT, description TEXT, auth TEXT, cors TEXT, link TEXT, category Text)",
        );
      },
    );
    return _database;
  }

  Future<int?> insertData(ApiData apidata) async {
    await openDb();
    int? id = await _database?.insert('data', apidata.toMap());
    return id;
  }

  Future<List<ApiData>> getDataList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.rawQuery('SELECT * FROM data');
    return List.generate(maps.length, (i) {
      return ApiData(
        api: maps[i]['api'],
        description: maps[i]['description'],
        auth: maps[i]['auth'],
        cors: maps[i]['cors'],
        link: maps[i]['link'],
        category: maps[i]['category'],

      );
    });
  }

  Future<List<Map<String, dynamic>>> getItemsSortedByCategory(String category) async {
    await openDb();

  return await _database!.query('data', orderBy: 'category', where: 'category = ?', whereArgs: [category]);
  }

Future<void> deleteRow(String value) async {
    await openDb();

    await _database!.delete(
      'data',
      where: 'api = ?',
      whereArgs: [value],
    );
  }


Future<void> updateData(String? specificValue, String? newApi, String? newDescription) async {
  await openDb(); 

    await _database!.update(
      'data', 
      {
        'api': newApi,
        'description': newDescription,

      }, 
      where: 'api = ?', 
      whereArgs: [specificValue], // Pass the specific value as a whereArgs parameter
    );

}

}

