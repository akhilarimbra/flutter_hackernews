import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import '../models/Item.dart';
import '../resources/Repository.dart';

final String _table = 'items';

class NewsDBProvider implements Source, Cache {
  Database database;

  NewsDBProvider() {
    init();
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'items.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDatabase, int version) {
        newDatabase.execute("""
            CREATE TABLE $_table(
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
          """);
      },
    );
  }

  Future<List<int>> fetchTopIds() =>
      null; // To fix abstract class Source params

  Future<ItemModel> fetchItem(int id) async {
    final maps = await database.query(
      _table,
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDatabase(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return database.insert(_table, item.toMapDatabase());
  }
}

final newsDBProvider = NewsDBProvider();
