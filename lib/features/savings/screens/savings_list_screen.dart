import 'package:flutter/material.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/providers/card_data_provider.dart';
import '../../home/screens/transaction_details_screen.dart';

class SavingsListScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final String? mainAccountBalance;
  const SavingsListScreen({super.key, this.onBackToHome, this.mainAccountBalance});

  State<SavingsListScreen> createState() => _SavingsListScreenState();
}

class _SavingsListScreenState extends State<SavingsListScreen> {
  // Individual visibility state for each savings account
  late final List<bool> _accountVisibility;
  
  // Use centralized card data provider for better performance
  late final CardDataProvider _cardDataProvider = CardDataProvider();

  @override
  void initState() {
    super.initState();
    // Initialize visibility state for each savings account (all hidden by default)
    final savingsAccounts = _cardDataProvider.convertToSavingsAccounts(widget.mainAccountBalance);
    _accountVisibility = List.filled(savingsAccounts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppPalette>()!;
    
    // Use centralized data conversion for consistency and performance
    final savingsAccounts = _cardDataProvider.convertToSavingsAccounts(widget.mainAccountBalance);
    
    final l10n = AppLocalizations.of(context);
    
    final savingsProducts = [
      {
        'title': l10n.shareAccount,
        'description': 'Membership share contribution',
        'interestRate': '6 %',
        'minDeposit': '100.00 ETB',
        'maxDeposit': '50,000.00 ETB',
      },
      {
        'title': l10n.regularSavings,
        'description': 'Monthly savings account',
        'interestRate': '7 %',
        'minDeposit': '50.00 ETB',
        'maxDeposit': l10n.noLimit,
      },
      {
        'title': '${l10n.fixedDeposit} 6M',
        'savingDays': '180',
        'description': 'Fixed term deposit',
        'interestRate': '9 %',
        'minDeposit': '5,000.00 ETB',
        'maxDeposit': '500,000.00 ETB',
      },
      {
        'title': l10n.fixedDeposit,
        'savingDays': '365',
        'description': 'Long-term fixed deposit',
        'interestRate': '11 %',
        'minDeposit': '10,000.00 ETB',
        'maxDeposit': '1,000,000.00 ETB',
      },
      {
        'title': l10n.childrenEducation,
        'description': 'Education savings for children',
        'interestRate': '8 %',
        'minDeposit': '25.00 ETB',
        'maxDeposit': '100,000.00 ETB',
      },
    ];

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).savingsScreen,
            onBackPressed: () {
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Savings Accounts Carousel Section
                  if (savingsAccounts.isNotEmpty) ...[
                    Container(
                      decoration: BoxDecoration(color: palette.sectionBg),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        height: 170, // Increased height to prevent overflow
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: savingsAccounts.length,
                          itemBuilder: (context, index) {
                            final account = savingsAccounts[index];
                            return SizedBox(
                              width: 320, // Slightly reduced width for each card
                              child: _buildSavingsAccountCard(account, palette, index),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
          
          // Savings Products Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.savingsAccounts,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: palette.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Products list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: savingsProducts.length,
            itemBuilder: (context, index) {
                final product = savingsProducts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: palette.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product['title']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: palette.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (product['description'] != null) ...[
                        Text(
                          product['description']!,
                          style: TextStyle(
                            color: palette.textSecondary,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                      if (product['savingDays'] != null) ...[
                        Text(
                          '${l10n.savingDays}: ${product['savingDays']}',
                          style: TextStyle(
                            color: palette.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        '${l10n.interestRate}: ${product['interestRate']}',
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.minDeposit}: ${product['minDeposit']}',
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.maxDeposit}: ${product['maxDeposit']}',
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(l10n.view),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build individual savings account card with onClick functionality
  Widget _buildSavingsAccountCard(Map<String, dynamic> account, AppPalette palette, int accountIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to savings account details
            print('🔵 Savings Card Tapped: ${account['title']}'); // Debug print
            try {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionDetailsScreen(
                    title: account['title'] as String,
                    isLoan: false,
                    isShare: account['accountType'] == 'Share',
                    accountNumber: account['accountNumber'] as String,
                    balance: account['balance'] as double,
                    accountType: account['accountType'] as String,
                  ),
                ),
              );
            } catch (e) {
              print('❌ Navigation Error: $e');
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  palette.cardBg,
                  palette.cardBg.withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: palette.cardBorder.withOpacity(0.5), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Compact header with eye icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          account['title'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: palette.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _accountVisibility[accountIndex] = !_accountVisibility[accountIndex];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: palette.sectionBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            _accountVisibility[accountIndex] ? Icons.visibility : Icons.visibility_off,
                            color: palette.textSecondary,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    account['accountNumber'] as String,
                    style: TextStyle(
                      color: palette.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Balance row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).balance,
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 9,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _accountVisibility[accountIndex] 
                                  ? '${(account['balance'] as double).toStringAsFixed(2)}'
                                  : '••••••••',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.green[700],
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          account['interestRate'] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Footer info
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: palette.sectionBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          size: 11,
                          color: palette.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            account['lastTransaction'] as String,
                            style: TextStyle(
                              color: palette.textSecondary,
                              fontSize: 9,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          account['lastTransactionDate'] as String,
                          style: TextStyle(
                            color: palette.textSecondary,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


