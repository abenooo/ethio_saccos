import 'package:flutter/foundation.dart';

/// Centralized provider for card data to ensure consistency across the app
class CardDataProvider {
  // Singleton pattern for better performance
  static final CardDataProvider _instance = CardDataProvider._internal();
  factory CardDataProvider() => _instance;
  CardDataProvider._internal();

  // Default card data - single source of truth
  static const String defaultMainAccountBalance = '2,000,000.00 ETB';
  static const Map<String, dynamic> defaultLoanCardData = {
    'title': 'Personal Loan',
    'amount': '50,000.00 ETB',
    'info1': '1213123123123456',
    'info2': 'Loan Account',
  };

  // Main account card data
  static const Map<String, dynamic> mainAccountCardData = {
    'title': 'Abenezer Kifle',
    'amount': defaultMainAccountBalance,
    'info1': '1213123123123123',
    'info2': 'Main Account',
  };

  // All card data for consistency
  static const List<Map<String, dynamic>> allCardData = [
    mainAccountCardData,
    defaultLoanCardData,
    {
      'title': 'Savings Account',
      'amount': '85,500.00 ETB',
      'info1': '1213123123123789',
      'info2': 'Savings Account',
    },
    {
      'title': 'Share Account',
      'amount': '45,000.00 ETB',
      'info1': '1213123123123890',
      'info2': 'Share Investment',
    },
  ];

  /// Get main account balance
  String getMainAccountBalance() => defaultMainAccountBalance;

  /// Get loan card data
  Map<String, dynamic> getLoanCardData() => defaultLoanCardData;

  /// Get main account card data
  Map<String, dynamic> getMainAccountCardData() => mainAccountCardData;

  /// Get all card data
  List<Map<String, dynamic>> getAllCardData() => allCardData;

  /// Find card by title
  Map<String, dynamic>? findCardByTitle(String title) {
    try {
      return allCardData.firstWhere(
        (card) => card['title'] == title,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Card not found: $title');
      }
      return null;
    }
  }

  /// Convert card data to savings accounts format
  List<Map<String, dynamic>> convertToSavingsAccounts(String? mainAccountBalance) {
    final balance = mainAccountBalance ?? defaultMainAccountBalance;
    final balanceValue = double.tryParse(
      balance.replaceAll(' ETB', '').replaceAll(',', '')
    ) ?? 2000000.0;

    return [
      {
        'title': 'Share Account',
        'accountNumber': 'SA-001-2024',
        'balance': balanceValue * 0.0225, // 2.25% of main balance (45,000 ETB)
        'lastTransaction': 'Deposit +2,500 ETB',
        'lastTransactionDate': '2 days ago',
        'interestRate': '6.5%',
        'accountType': 'Share',
      },
      {
        'title': 'Regular Savings',
        'accountNumber': 'RS-002-2024',
        'balance': balanceValue * 0.014375, // 1.4375% of main balance (28,750 ETB)
        'lastTransaction': 'Deposit +1,200 ETB',
        'lastTransactionDate': '5 days ago',
        'interestRate': '7.0%',
        'accountType': 'Savings',
      },
      {
        'title': 'Fixed Deposit 12M',
        'accountNumber': 'FD-003-2024',
        'balance': balanceValue * 0.0625, // 6.25% of main balance (125,000 ETB)
        'lastTransaction': 'Interest +1,875 ETB',
        'lastTransactionDate': '1 week ago',
        'interestRate': '9.5%',
        'accountType': 'Fixed Deposit',
        'maturityDate': 'Dec 15, 2024',
      },
      {
        'title': 'Emergency Fund',
        'accountNumber': 'EF-004-2024',
        'balance': balanceValue * 0.00775, // 0.775% of main balance (15,500 ETB)
        'lastTransaction': 'Deposit +500 ETB',
        'lastTransactionDate': '3 days ago',
        'interestRate': '5.5%',
        'accountType': 'Emergency',
      },
      {
        'title': 'Children Education',
        'accountNumber': 'CE-005-2024',
        'balance': balanceValue * 0.015, // 1.5% of main balance (30,000 ETB)
        'lastTransaction': 'Deposit +1,000 ETB',
        'lastTransactionDate': '1 week ago',
        'interestRate': '8.0%',
        'accountType': 'Education',
      },
      {
        'title': 'Holiday Savings',
        'accountNumber': 'HS-006-2024',
        'balance': balanceValue * 0.0075, // 0.75% of main balance (15,000 ETB)
        'lastTransaction': 'Deposit +750 ETB',
        'lastTransactionDate': '4 days ago',
        'interestRate': '6.0%',
        'accountType': 'Holiday',
      },
    ];
  }

  /// Convert card data to loan accounts format
  List<Map<String, dynamic>> convertToLoanAccounts(dynamic loanCardData) {
    // Handle both CardData objects and Map objects
    String title, amount, info1;
    
    if (loanCardData is Map) {
      title = loanCardData['title'] ?? 'Personal Loan';
      amount = loanCardData['amount'] ?? '50,000.00 ETB';
      info1 = loanCardData['info1'] ?? '1213123123123456';
    } else if (loanCardData != null) {
      // Assume it's a CardData object with properties
      title = loanCardData.title ?? 'Personal Loan';
      amount = loanCardData.amount ?? '50,000.00 ETB';
      info1 = loanCardData.info1 ?? '1213123123123456';
    } else {
      // Use defaults
      title = defaultLoanCardData['title'] as String;
      amount = defaultLoanCardData['amount'] as String;
      info1 = defaultLoanCardData['info1'] as String;
    }
    
    // Parse amount to get balance
    final amountStr = amount.replaceAll(' ETB', '').replaceAll(',', '');
    final balance = double.tryParse(amountStr) ?? 50000.0;
    
    return [
      {
        'title': title,
        'accountNumber': 'PL-${info1.substring(info1.length - 4)}-2024',
        'balance': balance,
        'originalAmount': balance * 1.5, // Assume 50% paid off
        'lastPayment': 'Payment -${(balance * 0.05).toStringAsFixed(0)} ETB',
        'lastPaymentDate': '1 week ago',
        'interestRate': '12.0%',
        'monthlyPayment': balance * 0.0625, // ~6.25% of remaining balance
        'remainingMonths': 18,
        'loanType': 'Personal',
      },
    ];
  }
}
