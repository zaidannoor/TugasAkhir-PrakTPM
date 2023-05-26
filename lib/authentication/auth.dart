import "../db/database_helper.dart";

class Auth {
  static Future<void> registerUser({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> user = {
      'username': username,
      'password': password,
    };
    await DatabaseHelper.instance.insertUser(user);
  }

  static Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUsers();
    for (var user in users) {
      if (user['username'] == username && user['password'] == password) {
        return true;
      }
    }
    return false;
  }
}
