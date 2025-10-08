import 'package:flutter/material.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/providers/card_data_provider.dart';
import 'loan_details_screen.dart';

class LoansListScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final dynamic loanCardData; // Add loan card data parameter
  const LoansListScreen({super.key, this.onBackToHome, this.loanCardData});

  @override
  State<LoansListScreen> createState() => _LoansListScreenState();
}

class _LoansListScreenState extends State<LoansListScreen> {
  bool _isBalanceVisible = false;
  
  // Use centralized card data provider for better performance
  late final CardDataProvider _cardDataProvider = CardDataProvider();
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    // Use centralized data conversion for consistency and performance
    final loanAccounts = _cardDataProvider.convertToLoanAccounts(widget.loanCardData);

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).loansScreen,
            onBackPressed: () {
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          // Light section header (from theme palette)
          Container(
            decoration: BoxDecoration(color: palette.sectionBg),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                children: [
                  // Total loan balance card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: palette.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: palette.cardBorder,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.totalLoanBalance.toUpperCase(),
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isBalanceVisible = !_isBalanceVisible;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: palette.cardBg,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: palette.cardBorder),
                                ),
                                child: Icon(
                                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                                  color: palette.iconPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Two column layout matching savings design
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.account_balance,
                                  color: palette.iconPrimary,
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.remainingLoan,
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isBalanceVisible 
                                      ? '- ${loanAccounts.fold<double>(0, (sum, loan) => sum + (loan['balance'] as double)).toStringAsFixed(2)} ETB'
                                      : '******************',
                                  style: TextStyle(
                                    color: _isBalanceVisible ? Colors.red[600] : palette.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 60,
                              width: 1,
                              color: palette.cardBorder,
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: palette.iconPrimary,
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.totalInterest,
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isBalanceVisible ? '3,600.00 ETB' : '******************',
                                  style: TextStyle(
                                    color: palette.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Initial loan information
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: palette.cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: palette.cardBorder),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    color: palette.iconPrimary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${l10n.initialLoanProvided}:',
                                    style: TextStyle(
                                      color: palette.textSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _isBalanceVisible ? '- 45,000.00 ETB' : '******************',
                                style: TextStyle(
                                  color: _isBalanceVisible ? Colors.red[600] : palette.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SACCO Loans section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.cardBorder, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance,
                    color: cs.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l10n.loanServices,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: palette.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: palette.iconPrimary.withOpacity(0.6),
                  size: 16,
                ),
              ],
            ),
          ),
          // Loan accounts list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: loanAccounts.length,
              itemBuilder: (context, index) {
                final loan = loanAccounts[index];
                return InkWell(
                  onTap: () {
                    // Navigate to loan details screen for this account
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoanDetailsScreen(
                          title: loan['title'] as String,
                          loanAmount: loan['balance'] as double,
                          interestRate: double.tryParse(loan['interestRate'].toString().replaceAll('%', '')) ?? 12.0,
                          loanTermMonths: loan['remainingMonths'] as int,
                          startDate: DateTime.now().subtract(Duration(days: 365)),
                          isFromLoanCard: true,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: palette.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loan['title'] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: palette.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    loan['accountNumber'] as String,
                                    style: TextStyle(
                                      color: palette.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _isBalanceVisible 
                                      ? '- ${(loan['balance'] as double).toStringAsFixed(2)} ETB'
                                      : '••••••••',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    loan['interestRate'] as String,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red[600],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              size: 14,
                              color: palette.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                loan['lastPayment'] as String,
                                style: TextStyle(
                                  color: palette.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              loan['lastPaymentDate'] as String,
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${l10n.monthlyPayment}: ${(loan['monthlyPayment'] as double).toStringAsFixed(2)} ETB',
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${loan['remainingMonths']} ${l10n.monthsLeft}',
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


