import 'package:inventech/Core/DB_Helper/db_helper.dart';

class UserLocalDatasource {
  Future<bool> validateUser(String email, String password) async {
    final db = await DBHelper.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      await db.update(
        'users',
        {'loggedIn': 1},
        where: 'email = ?',
        whereArgs: [email],
      );
      return true;
    }
    return false;
  }

  Future<bool> isUserLoggedIn() async {
    final db = await DBHelper.database;

    final result = await db.query(
      'users',
      where: 'loggedIn = ?',
      whereArgs: [1],
    );
    return result.isNotEmpty;
  }

  Future<void> logout() async {
    final db = await DBHelper.database;
    await db.update('users', {'loggedIn': 0});
  }
}
