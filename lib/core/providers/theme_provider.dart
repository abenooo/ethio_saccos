import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get theme {
    if (_isDarkMode) {
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1B1E),
        primaryColor: Colors.blue[700],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[700]!,
          secondary: Colors.blue[500]!,
          surface: const Color(0xFF2A2B31),
          background: const Color(0xFF1A1B1E),
          onPrimary: Colors.white,
          onSecondary: Colors.white70,
          onSurface: Colors.white,
          onBackground: Colors.white70,
        ),
        extensions: [
          AppGradients(
            headerGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF1A1B1E), const Color(0xFF1A1B1E)],
            ),
            cardGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF2A2B31), const Color(0xFF2A2B31)],
            ),
          ),
        ],
      );
    } else {
      return ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue[700],
        colorScheme: ColorScheme.light(
          primary: Colors.blue[700]!,
          secondary: Colors.blue[500]!,
          surface: const Color(0xFFEDF3FF),
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.blue[700]!,
          onSurface: Colors.blue[700]!,
          onBackground: Colors.black87,
        ),
        extensions: [
          AppGradients(
            headerGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[700]!, Colors.blue[500]!],
            ),
            cardGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[600]!, Colors.blue[400]!],
            ),
          ),
        ],
      );
    }
  }
}
