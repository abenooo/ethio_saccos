import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/custom_app_bar.dart';

class SavingsListScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  const SavingsListScreen({super.key, this.onBackToHome});

  @override
  State<SavingsListScreen> createState() => _SavingsListScreenState();
}

class _SavingsListScreenState extends State<SavingsListScreen> {
  bool _isBalanceVisible = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppPalette>()!;
    
    final savingsProducts = [
      {
        'title': 'SACCO Share Account',
        'description': 'Membership share contribution',
        'interestRate': '6 %',
        'minDeposit': '100.00 ETB',
        'maxDeposit': '50,000.00 ETB',
      },
      {
        'title': 'SACCO Regular Savings',
        'description': 'Monthly savings account',
        'interestRate': '7 %',
        'minDeposit': '50.00 ETB',
        'maxDeposit': 'No Limit',
      },
      {
        'title': 'SACCO Fixed Deposit 6M',
        'savingDays': '180',
        'description': 'Fixed term deposit',
        'interestRate': '9 %',
        'minDeposit': '5,000.00 ETB',
        'maxDeposit': '500,000.00 ETB',
      },
      {
        'title': 'SACCO Fixed Deposit 12M',
        'savingDays': '365',
        'description': 'Long-term fixed deposit',
        'interestRate': '11 %',
        'minDeposit': '10,000.00 ETB',
        'maxDeposit': '1,000,000.00 ETB',
      },
      {
        'title': 'SACCO Children Savings',
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
            title: 'SACCO Savings',
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
                  // Total savings balance card
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
                              'TOTAL SAVINGS BALANCE',
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
                        // Two column layout matching loan design
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  color: palette.iconPrimary,
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Total Savings',
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isBalanceVisible ? '25,450.00 ETB' : '******************',
                                  style: TextStyle(
                                    color: palette.textPrimary,
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
                                  'Total Interest',
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isBalanceVisible ? '1,850.75 ETB' : '******************',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Products list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
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
                          'Saving days: ${product['savingDays']}',
                          style: TextStyle(
                            color: palette.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        'Interest Rate: ${product['interestRate']}',
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Min Deposit: ${product['minDeposit']}',
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Max Deposit: ${product['maxDeposit']}',
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
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Detail'),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
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


