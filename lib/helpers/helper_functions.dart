import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/model_content.dart';

class HelperFunctions {
  static GetData() async {
    WidgetsFlutterBinding.ensureInitialized();

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "content.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e.toString());
      }

      ByteData data = await rootBundle.load(join("assets", "content.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      print("Database created successfully");
    } else {
      print("Opening existing database");
    }

    final database = await openDatabase(path, readOnly: false);

    final dbClient = await database;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM ContentDB');
    List<Content> entries = [];
    for (int i = 0; i < list.length; i++) {
      entries.add(Content(list[i]["id"], list[i]["type"], list[i]["group_id"],
          list[i]["name"], list[i]["thumbnail"]));
    }

    return entries;
  }
}
