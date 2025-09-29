import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'SACCOS';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.saccos.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int defaultPageSize = 20;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
  
  static const double defaultElevation = 2.0;
  static const double cardElevation = 4.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Form Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const double minLoanAmount = 1000.0;
  static const double maxLoanAmount = 10000000.0;
  static const double minInterestRate = 0.1;
  static const double maxInterestRate = 50.0;
  static const int minLoanTermMonths = 1;
  static const int maxLoanTermYears = 30;
  
  // Currency
  static const String currency = 'ETB';
  static const String currencySymbol = 'Br';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String apiDateFormat = 'yyyy-MM-dd';
  
  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unexpected error occurred. Please try again.';
  static const String sessionExpired = 'Your session has expired. Please log in again.';
  
  // Success Messages
  static const String calculationSuccess = 'Loan calculation completed successfully';
  static const String applicationSubmitted = 'Loan application submitted successfully';
  static const String dataUpdated = 'Data updated successfully';
}

class AppSizes {
  // Icon Sizes
  static const double iconXSmall = 16.0;
  static const double iconSmall = 20.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Button Heights
  static const double buttonHeight = 48.0;
  static const double smallButtonHeight = 36.0;
  static const double largeButtonHeight = 56.0;
  
  // Card Dimensions
  static const double cardMinHeight = 120.0;
  static const double cardMaxWidth = 400.0;
  
  // Grid Spacing
  static const double gridSpacing = 16.0;
  static const double listSpacing = 12.0;
  
  // App Bar
  static const double appBarHeight = 80.0;
  static const double bottomNavHeight = 60.0;
}

class AppTextStyles {
  // Consistent text styles that complement the theme
  static TextStyle get displayLarge => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static TextStyle get displayMedium => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
  );
  
  static TextStyle get headlineLarge => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle get headlineMedium => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle get titleLarge => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle get titleMedium => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  
  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  
  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  
  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  
  static TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  
  static TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  
  static TextStyle get labelSmall => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}

class AppDecorations {
  // Common input decoration
  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? suffixText,
    bool enabled = true,
    required BuildContext context,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      suffixText: suffixText,
      enabled: enabled,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
  
  // Common card decoration
  static BoxDecoration cardDecoration({
    required BuildContext context,
    Color? color,
    double? borderRadius,
    bool hasShadow = true,
  }) {
    return BoxDecoration(
      color: color ?? Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(
        borderRadius ?? AppConstants.defaultBorderRadius,
      ),
      boxShadow: hasShadow ? [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ] : null,
    );
  }
  
  // Common button style
  static ButtonStyle elevatedButtonStyle({
    required BuildContext context,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      foregroundColor: foregroundColor ?? Colors.white,
      minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppConstants.defaultBorderRadius,
        ),
      ),
    );
  }
  
  static ButtonStyle outlinedButtonStyle({
    required BuildContext context,
    Color? borderColor,
    Color? foregroundColor,
    double? borderRadius,
  }) {
    return OutlinedButton.styleFrom(
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
      minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
      side: BorderSide(
        color: borderColor ?? Theme.of(context).colorScheme.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppConstants.defaultBorderRadius,
        ),
      ),
    );
  }
}
