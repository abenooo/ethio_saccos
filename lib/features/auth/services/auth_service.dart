import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _kAuthKey = 'auth_logged_in';
  
  // Demo credentials for testing
  static const String demoEmail = 'demo@ethiosaccos.com';
  static const String demoPassword = 'demo123';

  static Future<bool> isLoggedIn() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kAuthKey) ?? false;
  }

  /// Validate credentials without logging in
  static bool validateCredentials(String email, String password) {
    // Accept any non-empty credentials for demo purposes
    return email.isNotEmpty && password.isNotEmpty;
  }

  /// Login with email and password validation
  static Future<bool> login({String? email, String? password}) async {
    // Accept any non-empty credentials for demo purposes
    if (email != null && password != null) {
      // Validate credentials first
      if (validateCredentials(email, password)) {
        final p = await SharedPreferences.getInstance();
        await p.setBool(_kAuthKey, true);
        return true;
      }
      return false;
    } else {
      // Legacy support - login without credentials (for existing code)
      final p = await SharedPreferences.getInstance();
      await p.setBool(_kAuthKey, true);
      return true;
    }
  }

  static Future<void> logout() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_kAuthKey);
  }
}


