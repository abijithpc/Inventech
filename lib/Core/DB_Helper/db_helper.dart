import 'package:inventech/Core/constant/constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create user table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            loggedIn INTEGER NOT NULL DEFAULT 0

          )
        ''');

        await db.insert('users', {
          'email': defaultEmail,
          'password': defaultPassword,
          'loggedIn': 0,
        });
      },
    );
  }
}
