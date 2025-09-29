import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/theme/theme.dart';
import '../../../core/models/loan_models.dart';
import '../../../core/services/loan_history_service.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/constants/app_constants.dart';
import 'loan_details_screen.dart';

class LoanHistoryScreen extends StatefulWidget {
  const LoanHistoryScreen({super.key});

  @override
  State<LoanHistoryScreen> createState() => _LoanHistoryScreenState();
}

class _LoanHistoryScreenState extends State<LoanHistoryScreen> {
  List<LoanHistoryItem> _historyItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);
    try {
      final history = await LoanHistoryService.getLoanHistory();
      setState(() {
        _historyItems = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        AppUtils.showSnackBar(
          context,
          'Error loading loan history',
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _deleteHistoryItem(String id) async {
    final confirmed = await AppUtils.showConfirmationDialog(
      context,
      title: 'Delete Loan Calculation',
      message: 'Are you sure you want to delete this loan calculation from history?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (confirmed == true) {
      await LoanHistoryService.deleteLoanHistory(id);
      _loadHistory();
      if (mounted) {
        AppUtils.showSnackBar(
          context,
          'Loan calculation deleted',
          type: SnackBarType.success,
        );
      }
    }
  }

  Future<void> _clearAllHistory() async {
    final confirmed = await AppUtils.showConfirmationDialog(
      context,
      title: 'Clear All History',
      message: 'Are you sure you want to clear all loan calculation history? This action cannot be undone.',
      confirmText: 'Clear All',
      cancelText: 'Cancel',
    );

    if (confirmed == true) {
      await LoanHistoryService.clearAllHistory();
      _loadHistory();
      if (mounted) {
        AppUtils.showSnackBar(
          context,
          'All loan history cleared',
          type: SnackBarType.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppPalette>()!;

    return Scaffold(
      backgroundColor: cs.background,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Loan History',
            onBackPressed: () => Navigator.maybePop(context),
            actions: _historyItems.isNotEmpty ? [
              IconButton(
                icon: Icon(Icons.delete_sweep, color: palette.textSecondary),
                onPressed: _clearAllHistory,
                tooltip: 'Clear All History',
              ),
            ] : null,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _historyItems.isEmpty
                    ? _buildEmptyState(palette)
                    : _buildHistoryList(palette),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppPalette palette) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: palette.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No Loan History',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: palette.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your calculated loans will appear here.\nStart by calculating a loan to see your history.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: palette.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('Calculate a Loan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(AppPalette palette) {
    return RefreshIndicator(
      onRefresh: _loadHistory,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: _historyItems.length,
        itemBuilder: (context, index) {
          final item = _historyItems[index];
          return _buildHistoryCard(item, palette);
        },
      ),
    );
  }

  Widget _buildHistoryCard(LoanHistoryItem item, AppPalette palette) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        onTap: () => _viewLoanDetails(item),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.loanTypeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getLoanTypeIcon(item.loanType),
                      color: item.loanTypeColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.loanTypeDisplayName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: palette.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        _deleteHistoryItem(item.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 18),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      'Amount',
                      AppUtils.formatCurrencyCompact(item.loanAmount),
                      palette,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      'Monthly Payment',
                      AppUtils.formatCurrencyCompact(item.monthlyPayment),
                      palette,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      'Interest Rate',
                      '${item.interestRate.toStringAsFixed(1)}%',
                      palette,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      'Term',
                      '${(item.loanTermMonths / 12).toStringAsFixed(0)} years',
                      palette,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Calculated ${AppUtils.formatDate(item.calculatedAt, format: 'MMM dd, yyyy \'at\' HH:mm')}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: palette.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, AppPalette palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: palette.textSecondary,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: palette.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData _getLoanTypeIcon(LoanType loanType) {
    switch (loanType) {
      case LoanType.personal:
        return Icons.person;
      case LoanType.business:
        return Icons.business;
      case LoanType.mortgage:
        return Icons.home;
      case LoanType.auto:
        return Icons.directions_car;
    }
  }

  void _viewLoanDetails(LoanHistoryItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoanDetailsScreen(
          title: item.loanTypeDisplayName,
          loanAmount: item.loanAmount,
          interestRate: item.interestRate,
          loanTermMonths: item.loanTermMonths,
          startDate: item.startDate,
        ),
      ),
    );
  }
}
