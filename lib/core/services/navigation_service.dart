import 'package:flutter/material.dart';
import '../../features/savings/screens/savings_list_screen.dart';
import '../../features/loans/screens/loans_list_screen.dart';
import '../../screens/main_navigation_screen.dart';
import '../providers/card_data_provider.dart';
import '../utils/page_transitions.dart';

/// Centralized navigation service for consistent navigation across the app
class NavigationService {
  // Singleton pattern for better performance
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();
  static final CardDataProvider _cardDataProvider = CardDataProvider();

  /// Navigate to savings screen with consistent data
  static void navigateToSavings(BuildContext context, {
    bool useBottomNavigation = false,
    String? customBalance,
  }) {
    final balance = customBalance ?? _cardDataProvider.getMainAccountBalance();
    
    if (useBottomNavigation) {
      context.pushAndRemoveUntilFade(
        MainNavigationScreen(
          initialIndex: 1, // Savings screen index
          mainAccountBalance: balance,
        ),
        (route) => false,
      );
    } else {
      context.pushFade(
        SavingsListScreen(
          mainAccountBalance: balance,
        ),
      );
    }
  }

  /// Navigate to loans screen with consistent data
  static void navigateToLoans(BuildContext context, {
    bool useBottomNavigation = false,
    Map<String, dynamic>? customLoanData,
  }) {
    final loanData = customLoanData ?? _cardDataProvider.getLoanCardData();
    
    if (useBottomNavigation) {
      context.pushAndRemoveUntilFade(
        MainNavigationScreen(
          initialIndex: 0, // Loans screen index
          loanCardData: loanData,
        ),
        (route) => false,
      );
    } else {
      context.pushFade(
        LoansListScreen(
          loanCardData: loanData,
        ),
      );
    }
  }

  /// Navigate to savings screen via bottom navigation with card data
  /// 
  /// Extracts the main account balance from the provided card list and navigates
  /// to the savings screen. Falls back to default balance if main account is not found.
  /// 
  /// Parameters:
  /// - [context]: BuildContext for navigation
  /// - [cards]: List of card data (supports both Map and CardData objects)
  static void navigateToSavingsWithCardData(BuildContext context, List<dynamic> cards) {
    assert(cards.isNotEmpty, 'Cards list should not be empty');
    
    String balance = _cardDataProvider.getMainAccountBalance();
    
    try {
      final mainAccount = cards.firstWhere(
        (card) => (card is Map ? card['title'] : card.title) == 'Abenezer Kifle',
      );
    } catch (_) {
      // Silently fall back to default balance - expected behavior
      balance = _cardDataProvider.getMainAccountBalance();
    }
    
    context.pushAndRemoveUntilFade(
      MainNavigationScreen(
        initialIndex: 1,
        mainAccountBalance: balance,
      ),
      (route) => false,
    );
  }

  /// Navigate to loans screen via bottom navigation with card data
  static void navigateToLoansWithCardData(BuildContext context, dynamic loanCard) {
    context.pushAndRemoveUntilFade(
      MainNavigationScreen(
        initialIndex: 0, // Loans screen index
        loanCardData: loanCard,
      ),
      (route) => false,
    );
  }

  /// Pop current screen
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Pop and close drawer if open
  static void popAndCloseDrawer(BuildContext context) {
    Navigator.pop(context); // Close drawer first
  }
}
