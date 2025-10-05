import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Premium brand color palette - Updated with yellow primary and dark chocolate secondary
  static const Color primaryYellow = Color(0xFFFBBD3E);     // Brand yellow (primary)
  static const Color secondaryDarkChocolate = Color(0xFF100D08); // Dark chocolate (secondary)
  static const Color accentOrange = Color(0xFFE6A82A);      // Darker yellow/orange
  static const Color successGreen = Color(0xFF059669);      // Emerald green
  static const Color warningOrange = Color(0xFFEA580C);     // Orange
  static const Color errorRed = Color(0xFFDC2626);          // Red
  static const Color neutralGray = Color(0xFF6B7280);       // Gray
  static const Color lightBlue = Color(0xFF3B82F6);         // Light blue

  ThemeData get theme {
    if (_isDarkMode) {
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: primaryYellow,
        colorScheme: ColorScheme.dark(
          primary: primaryYellow,
          secondary: secondaryDarkChocolate,
          surface: const Color(0xFF0F172A),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white70,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          headlineSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          bodyMedium: const TextStyle(fontSize: 14, color: Colors.white70),
          bodySmall: const TextStyle(fontSize: 12, color: Colors.white60),
        ),
        extensions: [
          AppGradients(
            headerGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD700), primaryYellow], // Gold to brand yellow
            ),
            cardGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryYellow, accentOrange],
            ),
          ),
          const AppPalette(
            sectionBg: Color(0xFF0F172A),
            cardBg: Color(0xFF1E293B),
            cardBorder: Color(0xFF334155),
            iconPrimary: Color(0xFFE2E8F0),
            textPrimary: Color(0xFFF8FAFC),
            textSecondary: Color(0xFFCBD5E1),
            dotActive: Color(0xFF3B82F6),
            dotInactive: Color(0xFF64748B),
          ),
        ],
      );
    } else {
      return ThemeData.light().copyWith(
        primaryColor: primaryYellow,
        colorScheme: ColorScheme.light(
          primary: primaryYellow,
          secondary: secondaryDarkChocolate,
          surface: const Color(0xFFF8FAFC),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF1E293B),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800]),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[800]),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey[700]),
          bodySmall: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        extensions: [
          AppGradients(
            headerGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD700), primaryYellow], // Gold to brand yellow
            ),
            cardGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryYellow, accentOrange],
            ),
          ),
          const AppPalette(
            sectionBg: Color(0xFFF8FAFC),
            cardBg: Color(0xFFFFFFFF),
            cardBorder: Color(0xFFE2E8F0),
            iconPrimary: Color(0xFF100D08), // Updated to secondary dark chocolate
            textPrimary: Color(0xFF100D08), // Updated to secondary dark chocolate
            textSecondary: Color(0xFF64748B),
            dotActive: Color(0xFF100D08), // Updated to secondary dark chocolate
            dotInactive: Color(0xFFCBD5E1),
          ),
        ],
      );
    }
  }
}
