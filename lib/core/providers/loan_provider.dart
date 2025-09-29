import 'package:flutter/foundation.dart';
import '../models/loan_models.dart';
import '../services/loan_calculation_service.dart';
import '../services/loan_history_service.dart';
import '../utils/logger.dart';

/// Provider for managing loan calculation state following Flutter best practices.
/// 
/// This provider handles:
/// - Loan calculation state management
/// - History management
/// - Error handling and loading states
/// - Reactive UI updates
class LoanProvider extends ChangeNotifier {
  // Private state variables
  LoanCalculationResponse? _currentCalculation;
  List<LoanHistoryItem> _history = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  // Public getters following Dart conventions
  LoanCalculationResponse? get currentCalculation => _currentCalculation;
  List<LoanHistoryItem> get history => List.unmodifiable(_history);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  
  /// Calculate loan with proper error handling and state management
  Future<void> calculateLoan(LoanCalculationRequest request) async {
    try {
      _setLoading(true);
      _clearError();
      
      AppLogger.info('Starting loan calculation', tag: 'LoanProvider');
      
      // Perform calculation
      final response = LoanCalculationService.calculateLoan(request);
      
      // Save to history
      await LoanHistoryService.saveLoanCalculation(
        loanType: request.loanType,
        loanAmount: request.loanAmount,
        interestRate: request.interestRate,
        loanTermMonths: request.loanTermMonths,
        startDate: request.startDate,
        response: response,
      );
      
      // Update state
      _currentCalculation = response;
      await _loadHistory(); // Refresh history
      
      AppLogger.info('Loan calculation completed successfully', tag: 'LoanProvider');
      
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to calculate loan',
        tag: 'LoanProvider',
        error: e,
        stackTrace: stackTrace,
      );
      _setError('Failed to calculate loan. Please check your inputs and try again.');
    } finally {
      _setLoading(false);
    }
  }
  
  /// Load loan history with error handling
  Future<void> loadHistory() async {
    try {
      _setLoading(true);
      _clearError();
      
      await _loadHistory();
      
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to load loan history',
        tag: 'LoanProvider',
        error: e,
        stackTrace: stackTrace,
      );
      _setError('Failed to load loan history.');
    } finally {
      _setLoading(false);
    }
  }
  
  /// Delete history item with optimistic updates
  Future<void> deleteHistoryItem(String id) async {
    // Store original history for rollback
    final originalHistory = List<LoanHistoryItem>.from(_history);
    
    try {
      // Optimistic update
      _history.removeWhere((item) => item.id == id);
      notifyListeners();
      
      // Perform actual deletion
      await LoanHistoryService.deleteLoanHistory(id);
      
      AppLogger.info('Deleted loan history item: $id', tag: 'LoanProvider');
      
    } catch (e, stackTrace) {
      // Revert optimistic update on error
      _history = originalHistory;
      notifyListeners();
      
      AppLogger.error(
        'Failed to delete loan history item',
        tag: 'LoanProvider',
        error: e,
        stackTrace: stackTrace,
      );
      _setError('Failed to delete loan history item.');
    }
  }
  
  /// Clear all history with confirmation
  Future<void> clearAllHistory() async {
    try {
      _setLoading(true);
      _clearError();
      
      await LoanHistoryService.clearAllHistory();
      _history.clear();
      
      AppLogger.info('Cleared all loan history', tag: 'LoanProvider');
      
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to clear loan history',
        tag: 'LoanProvider',
        error: e,
        stackTrace: stackTrace,
      );
      _setError('Failed to clear loan history.');
    } finally {
      _setLoading(false);
    }
  }
  
  /// Clear current error message
  void clearError() {
    _clearError();
  }
  
  // Private helper methods
  Future<void> _loadHistory() async {
    _history = await LoanHistoryService.getLoanHistory();
    notifyListeners();
  }
  
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
  
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }
  
  @override
  void dispose() {
    AppLogger.debug('LoanProvider disposed', tag: 'LoanProvider');
    super.dispose();
  }
}
