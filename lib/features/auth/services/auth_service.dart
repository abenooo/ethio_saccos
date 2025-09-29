import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _kAuthKey = 'auth_logged_in';

  static Future<bool> isLoggedIn() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kAuthKey) ?? false;
  }

  static Future<void> login() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kAuthKey, true);
  }

  static Future<void> logout() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_kAuthKey);
  }
}


