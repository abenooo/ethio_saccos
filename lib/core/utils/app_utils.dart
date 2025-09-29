import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class AppUtils {
  // Format currency with Ethiopian Birr
  static String formatCurrency(double amount, {bool showSymbol = true}) {
    final formatter = NumberFormat('#,##0.00');
    final formattedAmount = formatter.format(amount);
    return showSymbol ? '$formattedAmount ${AppConstants.currency}' : formattedAmount;
  }

  // Format currency without decimals for whole numbers
  static String formatCurrencyCompact(double amount, {bool showSymbol = true}) {
    final formatter = amount % 1 == 0 
        ? NumberFormat('#,##0') 
        : NumberFormat('#,##0.00');
    final formattedAmount = formatter.format(amount);
    return showSymbol ? '$formattedAmount ${AppConstants.currency}' : formattedAmount;
  }

  // Format percentage
  static String formatPercentage(double percentage, {int decimalPlaces = 1}) {
    final formatter = NumberFormat('0.${'0' * decimalPlaces}%');
    return formatter.format(percentage / 100);
  }

  // Format date
  static String formatDate(DateTime date, {String? format}) {
    final formatter = DateFormat(format ?? AppConstants.dateFormat);
    return formatter.format(date);
  }

  // Format date for API
  static String formatDateForApi(DateTime date) {
    final formatter = DateFormat(AppConstants.apiDateFormat);
    return formatter.format(date);
  }

  // Parse date from API
  static DateTime? parseDateFromApi(String dateString) {
    try {
      return DateFormat(AppConstants.apiDateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // Calculate loan payment using PMT formula
  static double calculateMonthlyPayment({
    required double principal,
    required double annualInterestRate,
    required int loanTermMonths,
  }) {
    if (annualInterestRate == 0) {
      return principal / loanTermMonths;
    }
    final monthlyRate = annualInterestRate / 100 / 12;
    final numerator = principal * monthlyRate * math.pow(1 + monthlyRate, loanTermMonths);
    final denominator = math.pow(1 + monthlyRate, loanTermMonths) - 1;
    
    final value = numerator / denominator;
    final min = 0.0;
    final max = principal;
    return math.min(math.max(value, min), max);
  }

  // Calculate remaining balance
  static double calculateRemainingBalance({
    required double principal,
    required double monthlyInterestRate,
    required double monthlyPayment,
    required int paymentsMade,
  }) {
    if (monthlyInterestRate == 0) {
      return principal - (monthlyPayment * paymentsMade);
    }

    final factor = math.pow(1 + monthlyInterestRate, paymentsMade);
    return principal * factor - monthlyPayment * (factor - 1) / monthlyInterestRate;
  }

  // Show snackbar with consistent styling
  static void showSnackBar(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      case SnackBarType.info:
        backgroundColor = Theme.of(context).colorScheme.primary;
        icon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
        ),
        margin: const EdgeInsets.all(AppConstants.defaultPadding),
      ),
    );
  }

  // Show loading dialog
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(message),
            ],
          ],
        ),
      ),
    );
  }

  // Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Show confirmation dialog
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // Validate Ethiopian phone number
  static bool isValidEthiopianPhone(String phone) {
    // Ethiopian phone numbers: +251XXXXXXXXX or 09XXXXXXXX or 07XXXXXXXX
    final regex = RegExp(r'^(\+251|0)[79]\d{8}$');
    return regex.hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  // Generate loan reference number
  static String generateLoanReference() {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch.toString().substring(8);
    return 'LN${now.year}${now.month.toString().padLeft(2, '0')}$timestamp';
  }

  // Debounce function for search
  static Timer? _debounceTimer;
  static void debounce(VoidCallback callback, {Duration delay = const Duration(milliseconds: 500)}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.shortestSide >= 600;
  }

  // Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    return EdgeInsets.all(isTablet(context) ? 24.0 : 16.0);
  }

  // Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final mediaQuery = MediaQuery.of(context);
    final scaleFactor = mediaQuery.textScaler.scale(1.0);
    return baseFontSize * scaleFactor.clamp(0.8, 1.2);
  }
}

enum SnackBarType {
  success,
  error,
  warning,
  info,
}
