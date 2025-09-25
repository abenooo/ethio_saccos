import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/custom_app_bar.dart';

class LoansListScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  const LoansListScreen({super.key, this.onBackToHome});

  @override
  State<LoansListScreen> createState() => _LoansListScreenState();
}

class _LoansListScreenState extends State<LoansListScreen> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loanProducts = [
      {
        'title': 'SACCO Emergency Loan',
        'creditLimit': 'Quick access loan for members',
        'limit': '15,000.00 ETB',
        'penalty': '2.0 %',
        'serviceCharge': '5.0 %',
        'installments': '1 Month',
      },
      {
        'title': 'SACCO Personal Loan',
        'creditLimit': 'Personal development loan',
        'limit': '25,000.00 ETB',
        'penalty': '1.5 %',
        'serviceCharge': '8.0 %',
        'installments': '3 Months',
      },
      {
        'title': 'SACCO Business Loan',
        'creditLimit': 'Small business development',
        'limit': '50,000.00 ETB',
        'penalty': '1.0 %',
        'serviceCharge': '12.0 %',
        'installments': '6 Months',
      },
      {
        'title': 'SACCO Asset Loan',
        'creditLimit': 'Asset purchase financing',
        'limit': '75,000.00 ETB',
        'penalty': '1.0 %',
        'serviceCharge': '15.0 %',
        'installments': '9 Months',
      },
      {
        'title': 'SACCO Development Loan',
        'creditLimit': 'Long-term development loan',
        'limit': '100,000.00 ETB',
        'penalty': '0.8 %',
        'serviceCharge': '18.0 %',
        'installments': '12 Months',
      },
    ];

    return Scaffold(
      backgroundColor: cs.background,
      body: Column(
        children: [
          CustomAppBar(
            title: 'SACCO Loans',
            onBackPressed: () {
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          // Theme gradient header
          Container(
            decoration: BoxDecoration(gradient: gradients.headerGradient),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                children: [
                  // Total loan balance card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TOTAL LOAN BALANCE',
                              style: TextStyle(
                                color: Colors.white,
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
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
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
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Remaining Loan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isBalanceVisible ? '- 30,000.00 ETB' : '******************',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 60,
                              width: 1,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Total Interest',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isBalanceVisible ? '3,600.00 ETB' : '******************',
                                  style: const TextStyle(
                                    color: Colors.white,
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
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Initial Loan Provided:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _isBalanceVisible ? '- 45,000.00 ETB' : '******************',
                                style: const TextStyle(
                                  color: Colors.white,
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary, width: 2),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'SACCO Loan Products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: cs.primary,
                  size: 16,
                ),
              ],
            ),
          ),
          // Products list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: loanProducts.length,
              itemBuilder: (context, index) {
                final product = loanProducts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05),
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
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product['creditLimit']!,
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Limit: ${product['limit']}',
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Penalty: ${product['penalty']}',
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Service charge: ${product['serviceCharge']}',
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No of Installment: ${product['installments']}',
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                          fontSize: 12,
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


