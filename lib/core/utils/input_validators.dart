import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputValidators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Phone number validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Amount validation
  static String? validateAmount(String? value, {double? minAmount, double? maxAmount}) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    
    final cleanValue = value.replaceAll(',', '');
    final amount = double.tryParse(cleanValue);
    
    if (amount == null) {
      return 'Please enter a valid amount';
    }
    
    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }
    
    if (minAmount != null && amount < minAmount) {
      return 'Amount must be at least ${NumberFormat('#,###').format(minAmount)} ETB';
    }
    
    if (maxAmount != null && amount > maxAmount) {
      return 'Amount cannot exceed ${NumberFormat('#,###').format(maxAmount)} ETB';
    }
    
    return null;
  }

  // Interest rate validation
  static String? validateInterestRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Interest rate is required';
    }
    
    final rate = double.tryParse(value);
    if (rate == null) {
      return 'Please enter a valid interest rate';
    }
    
    if (rate <= 0 || rate > 100) {
      return 'Interest rate must be between 0.1% and 100%';
    }
    
    return null;
  }

  // Loan term validation
  static String? validateLoanTerm(String? value, {int? minTerm, int? maxTerm}) {
    if (value == null || value.isEmpty) {
      return 'Loan term is required';
    }
    
    final term = int.tryParse(value);
    if (term == null) {
      return 'Please enter a valid loan term';
    }
    
    if (term <= 0) {
      return 'Loan term must be greater than 0';
    }
    
    if (minTerm != null && term < minTerm) {
      return 'Loan term must be at least $minTerm';
    }
    
    if (maxTerm != null && term > maxTerm) {
      return 'Loan term cannot exceed $maxTerm';
    }
    
    return null;
  }

  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Sanitize input to prevent injection attacks
  static String sanitizeInput(String input) {
    return input
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll(';', '')
        .replaceAll('&', '')
        .replaceAll('|', '')
        .replaceAll('`', '')
        .trim();
  }
}

// Number input formatter with comma separation
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    final number = int.tryParse(digitsOnly);
    if (number == null) {
      return oldValue;
    }

    final formatter = NumberFormat('#,###');
    final newText = formatter.format(number);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// Percentage input formatter
class PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Allow digits and one decimal point
    final filteredText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
    
    // Ensure only one decimal point
    final parts = filteredText.split('.');
    if (parts.length > 2) {
      return oldValue;
    }
    
    // Limit to 2 decimal places
    if (parts.length == 2 && parts[1].length > 2) {
      return oldValue;
    }
    
    // Limit percentage to 100
    final value = double.tryParse(filteredText);
    if (value != null && value > 100) {
      return oldValue;
    }

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
