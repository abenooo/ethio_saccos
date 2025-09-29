import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/loan_models.dart';
import '../utils/app_utils.dart';
import '../utils/logger.dart';

class LoanHistoryService {
  static const String _historyKey = 'loan_calculation_history';
  static const int _maxHistoryItems = 50; // Limit to prevent excessive storage

  static Future<void> saveLoanCalculation({
    required LoanType loanType,
    required double loanAmount,
    required double interestRate,
    required int loanTermMonths,
    required DateTime startDate,
    required LoanCalculationResponse response,
    String? customTitle,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyList = await getLoanHistory();

      final historyItem = LoanHistoryItem(
        id: AppUtils.generateLoanReference(),
        title: customTitle ?? _generateTitle(loanType, loanAmount),
        loanType: loanType,
        loanAmount: loanAmount,
        interestRate: interestRate,
        loanTermMonths: loanTermMonths,
        startDate: startDate,
        monthlyPayment: response.monthlyPayment,
        totalPayment: response.totalPayment,
        totalInterest: response.totalInterest,
        calculatedAt: response.calculatedAt,
      );

      historyList.insert(0, historyItem);

      // Limit history size
      if (historyList.length > _maxHistoryItems) {
        historyList.removeRange(_maxHistoryItems, historyList.length);
      }

      // Save to preferences
      final jsonList = historyList.map((item) => item.toJson()).toList();
      await prefs.setString(_historyKey, jsonEncode(jsonList));
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to save loan calculation to history',
        tag: 'LoanHistoryService',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  // Get loan calculation history
  static Future<List<LoanHistoryItem>> getLoanHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_historyKey);
      
      if (historyJson == null) return [];

      final List<dynamic> jsonList = jsonDecode(historyJson);
      return jsonList
          .map((json) => LoanHistoryItem.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to load loan history',
        tag: 'LoanHistoryService',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  // Delete a specific loan from history
  static Future<void> deleteLoanHistory(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyList = await getLoanHistory();
      
      historyList.removeWhere((item) => item.id == id);
      
      final jsonList = historyList.map((item) => item.toJson()).toList();
      await prefs.setString(_historyKey, jsonEncode(jsonList));
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to delete loan history item',
        tag: 'LoanHistoryService',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  // Clear all loan history
  static Future<void> clearAllHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_historyKey);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to clear loan history',
        tag: 'LoanHistoryService',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  // Update loan title
  static Future<void> updateLoanTitle(String id, String newTitle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyList = await getLoanHistory();
      
      final index = historyList.indexWhere((item) => item.id == id);
      if (index != -1) {
        historyList[index] = historyList[index].copyWith(title: newTitle);
        
        final jsonList = historyList.map((item) => item.toJson()).toList();
        await prefs.setString(_historyKey, jsonEncode(jsonList));
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update loan title',
        tag: 'LoanHistoryService',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  // Get history by loan type
  static Future<List<LoanHistoryItem>> getHistoryByType(LoanType loanType) async {
    final allHistory = await getLoanHistory();
    return allHistory.where((item) => item.loanType == loanType).toList();
  }

  // Generate a default title for the loan
  static String _generateTitle(LoanType loanType, double amount) {
    final formattedAmount = AppUtils.formatCurrencyCompact(amount);
    final typeString = loanType.name.toUpperCase();
    return '$typeString - $formattedAmount';
  }
}

class LoanHistoryItem {
  final String id;
  final String title;
  final LoanType loanType;
  final double loanAmount;
  final double interestRate;
  final int loanTermMonths;
  final DateTime startDate;
  final double monthlyPayment;
  final double totalPayment;
  final double totalInterest;
  final DateTime calculatedAt;

  const LoanHistoryItem({
    required this.id,
    required this.title,
    required this.loanType,
    required this.loanAmount,
    required this.interestRate,
    required this.loanTermMonths,
    required this.startDate,
    required this.monthlyPayment,
    required this.totalPayment,
    required this.totalInterest,
    required this.calculatedAt,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'loanType': loanType.name,
      'loanAmount': loanAmount,
      'interestRate': interestRate,
      'loanTermMonths': loanTermMonths,
      'startDate': startDate.toIso8601String(),
      'monthlyPayment': monthlyPayment,
      'totalPayment': totalPayment,
      'totalInterest': totalInterest,
      'calculatedAt': calculatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory LoanHistoryItem.fromJson(Map<String, dynamic> json) {
    return LoanHistoryItem(
      id: json['id'],
      title: json['title'],
      loanType: LoanType.values.firstWhere(
        (type) => type.name == json['loanType'],
        orElse: () => LoanType.personal,
      ),
      loanAmount: json['loanAmount'].toDouble(),
      interestRate: json['interestRate'].toDouble(),
      loanTermMonths: json['loanTermMonths'],
      startDate: DateTime.parse(json['startDate']),
      monthlyPayment: json['monthlyPayment'].toDouble(),
      totalPayment: json['totalPayment'].toDouble(),
      totalInterest: json['totalInterest'].toDouble(),
      calculatedAt: DateTime.parse(json['calculatedAt']),
    );
  }

  // Create a copy with updated fields
  LoanHistoryItem copyWith({
    String? title,
    LoanType? loanType,
    double? loanAmount,
    double? interestRate,
    int? loanTermMonths,
    DateTime? startDate,
    double? monthlyPayment,
    double? totalPayment,
    double? totalInterest,
    DateTime? calculatedAt,
  }) {
    return LoanHistoryItem(
      id: id,
      title: title ?? this.title,
      loanType: loanType ?? this.loanType,
      loanAmount: loanAmount ?? this.loanAmount,
      interestRate: interestRate ?? this.interestRate,
      loanTermMonths: loanTermMonths ?? this.loanTermMonths,
      startDate: startDate ?? this.startDate,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      totalPayment: totalPayment ?? this.totalPayment,
      totalInterest: totalInterest ?? this.totalInterest,
      calculatedAt: calculatedAt ?? this.calculatedAt,
    );
  }

  // Get loan type display name
  String get loanTypeDisplayName {
    switch (loanType) {
      case LoanType.personal:
        return 'Personal Loan';
      case LoanType.business:
        return 'Business Loan';
      case LoanType.mortgage:
        return 'Mortgage Loan';
      case LoanType.auto:
        return 'Auto Loan';
    }
  }

  // Get loan type color
  Color get loanTypeColor {
    switch (loanType) {
      case LoanType.personal:
        return const Color(0xFF059669); // Green
      case LoanType.business:
        return const Color(0xFF1E3A8A); // Blue
      case LoanType.mortgage:
        return const Color(0xFFD97706); // Orange
      case LoanType.auto:
        return const Color(0xFFDC2626); // Red
    }
  }
}
