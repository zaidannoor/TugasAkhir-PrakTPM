import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  bool _databaseInitialized = false;

  DatabaseHelper._();

  Future<Database> get database async {
  if (_databaseInitialized) {
    return _database!;
  } else {
    _database = await _initDatabase();
    return _database!;
  }
}

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'first_database.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
    _databaseInitialized = true;
    return database;
  }

  
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await instance.database;
    return await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await instance.database;
    return await db.query('users');
  }
}
