import 'dart:async';
import 'dart:io';

import 'package:blocwithoutplugin/data/model/home_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "rajkumarcrud.db";
  static final _databaseVersion = 1;

  static final table = 'ListlocalDB';

  static final columnPrimaryId = 'primaryid';
  static final columnId = 'id';
  static final columnDate = 'date';
  static final columnSlug = 'slug';
  static final columnType = 'type';
  static final columnLink = 'link';
  static final columnprotected = 'protected';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Lazily instantiate the database if unavailable
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database, creating if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE $table (
             $columnPrimaryId INTEGER PRIMARY KEY AUTOINCREMENT,
             $columnId INTEGER ,
             $columnDate TEXT,
             $columnSlug TEXT,
             $columnType TEXT,
             $columnLink TEXT,
             $columnprotected BOOLEAN)
           ''');
  }

  Future<int> insert(HomeModel note) async {
    Database db = await instance.database;
    return await db.insert(table, note.toJson());
  }

  // Retrieve all notes from the database
  Future<List<HomeModel>> getAllNotes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return HomeModel.fromJson(maps[i]);
    });
  }

  // Update a note in the database
  Future<int> update(HomeModel note) async {
    Database db = await instance.database;
    return await db.update(table, note.toJson(),
        where: '$columnId = ?', whereArgs: [note.id]);
  }

  // Delete a note from the database
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
