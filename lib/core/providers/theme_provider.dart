import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Premium brand color palette
  static const Color primaryBlue = Color(0xFF1E3A8A);      // Deep blue
  static const Color secondaryTeal = Color(0xFF0F766E);     // Teal
  static const Color accentGold = Color(0xFFD97706);        // Gold/amber
  static const Color successGreen = Color(0xFF059669);      // Emerald green
  static const Color warningOrange = Color(0xFFEA580C);     // Orange
  static const Color errorRed = Color(0xFFDC2626);          // Red
  static const Color neutralGray = Color(0xFF6B7280);       // Gray
  static const Color lightBlue = Color(0xFF3B82F6);         // Light blue

  ThemeData get theme {
    if (_isDarkMode) {
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: primaryBlue,
        colorScheme: ColorScheme.dark(
          primary: primaryBlue,
          secondary: secondaryTeal,
          surface: const Color(0xFF0F172A),
          onPrimary: Colors.white,
          onSecondary: Colors.white70,
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
              colors: [primaryBlue.withValues(alpha: 0.9), secondaryTeal.withValues(alpha: 0.7)],
            ),
            cardGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBlue, secondaryTeal],
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
        primaryColor: primaryBlue,
        colorScheme: ColorScheme.light(
          primary: primaryBlue,
          secondary: secondaryTeal,
          surface: const Color(0xFFF8FAFC),
          onPrimary: Colors.white,
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
              colors: [primaryBlue, secondaryTeal],
            ),
            cardGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBlue, lightBlue],
            ),
          ),
          const AppPalette(
            sectionBg: Color(0xFFF8FAFC),
            cardBg: Color(0xFFFFFFFF),
            cardBorder: Color(0xFFE2E8F0),
            iconPrimary: Color(0xFF475569),
            textPrimary: Color(0xFF1E293B),
            textSecondary: Color(0xFF64748B),
            dotActive: Color(0xFF1E3A8A),
            dotInactive: Color(0xFFCBD5E1),
          ),
        ],
      );
    }
  }
}
