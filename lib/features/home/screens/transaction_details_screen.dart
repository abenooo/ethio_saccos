import 'package:flutter/material.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/theme/theme.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final String title;
  final bool isLoan;
  final bool isShare;
  final VoidCallback? onBackToHome;
  final String? accountNumber;
  final double? balance;
  final String? accountType;
  
  const TransactionDetailsScreen({
    super.key, 
    required this.title, 
    this.isLoan = false, 
    this.isShare = false, 
    this.onBackToHome,
    this.accountNumber,
    this.balance,
    this.accountType,
  });

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> with TickerProviderStateMixin {
  int _tab = 0;
  late AnimationController _animationController;
  List<String> get _tabs {
    final l10n = AppLocalizations.of(context);
    if (widget.isLoan) return [l10n.all, l10n.repayments, l10n.disbursements];
    if (widget.isShare) return [l10n.all, l10n.buySell, l10n.dividends];
    return [l10n.all, l10n.deposits, l10n.withdrawals];
  }

  List<_Txn> _buildData() {
    if (widget.isLoan) {
      return [
        _Txn(label: 'Loan Disbursement', ok: true, outgoing: false, amount: 10000, date: '30/10/2019', party: 'Ethio SACCO'),
        _Txn(label: 'Monthly Repayment', ok: true, outgoing: true, amount: 1500, date: '05/11/2019', party: 'Loan Account'),
        _Txn(label: 'Interest Charge', ok: true, outgoing: true, amount: 350, date: '05/11/2019', party: 'Interest'),
        _Txn(label: 'Penalty', ok: false, outgoing: true, amount: 100, date: '10/11/2019', party: 'Penalty'),
      ];
    }
    if (widget.isShare) {
      return [
        _Txn(label: 'Dividend Payout', ok: true, outgoing: false, amount: 500, date: '30/10/2019', party: 'Ethio SACCO'),
        _Txn(label: 'Share Purchase', ok: true, outgoing: true, amount: 2000, date: '05/11/2019', party: 'Shares'),
        _Txn(label: 'Share Sell', ok: true, outgoing: false, amount: 1000, date: '10/11/2019', party: 'Shares'),
      ];
    }
    // Savings
    return [
      _Txn(label: 'Cash Deposit', ok: true, outgoing: false, amount: 5000, date: '30/10/2019', party: 'Branch Cashier'),
      _Txn(label: 'ATM Withdrawal', ok: true, outgoing: true, amount: 800, date: '01/11/2019', party: 'ATM 0123'),
      _Txn(label: 'Mobile Money Deposit', ok: true, outgoing: false, amount: 1200, date: '02/11/2019', party: 'Wallet'),
      _Txn(label: 'Transfer Out', ok: false, outgoing: true, amount: 600, date: '03/11/2019', party: 'Member 9876'),
    ];
  }

  IconData _getTransactionIcon(String label, bool isOutgoing) {
    if (label.toLowerCase().contains('deposit')) return Icons.add_circle_outline;
    if (label.toLowerCase().contains('withdrawal') || label.toLowerCase().contains('atm')) return Icons.remove_circle_outline;
    if (label.toLowerCase().contains('transfer')) return Icons.swap_horiz;
    if (label.toLowerCase().contains('loan') || label.toLowerCase().contains('disbursement')) return Icons.account_balance;
    if (label.toLowerCase().contains('repayment')) return Icons.payment;
    if (label.toLowerCase().contains('interest')) return Icons.percent;
    if (label.toLowerCase().contains('penalty')) return Icons.warning_outlined;
    if (label.toLowerCase().contains('dividend')) return Icons.trending_up;
    if (label.toLowerCase().contains('share')) return Icons.pie_chart_outline;
    if (label.toLowerCase().contains('mobile') || label.toLowerCase().contains('wallet')) return Icons.phone_android;
    return isOutgoing ? Icons.arrow_upward : Icons.arrow_downward;
  }

  IconData _getScreenIcon() {
    if (widget.isLoan) return Icons.account_balance;
    if (widget.isShare) return Icons.pie_chart;
    return Icons.account_balance_wallet;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppPalette>()!;
    
    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          CustomAppBar(
            title: widget.title,
            onBackPressed: () {
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          // Themed header section
          Container(
            decoration: BoxDecoration(
              color: palette.sectionBg,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Summary card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: palette.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: palette.cardBorder,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: palette.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: palette.cardBorder),
                        ),
                        child: Icon(
                          _getScreenIcon(),
                          color: palette.iconPrimary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: palette.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Transaction History',
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Filter tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: palette.cardBg,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: palette.cardBorder),
                  ),
                  child: Row(
                    children: List.generate(_tabs.length, (i) {
                      final selected = _tab == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _tab = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: selected ? cs.primary.withOpacity(0.12) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _tabs[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selected ? cs.primary : palette.textSecondary,
                                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Transaction list
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _buildData().where((t) {
                    if (_tab == 0) return true;
                    if (widget.isLoan) {
                      return _tab == 1 ? t.outgoing : !t.outgoing;
                    }
                    if (widget.isShare) {
                      return _tab == 1 ? t.outgoing : (!t.outgoing && t.label.contains('Dividend'));
                    }
                    return _tab == 1 ? !t.outgoing : t.outgoing;
                  }).length,
                  itemBuilder: (_, index) {
                    final data = _buildData().where((t) {
                      if (_tab == 0) return true;
                      if (widget.isLoan) {
                        return _tab == 1 ? t.outgoing : !t.outgoing;
                      }
                      if (widget.isShare) {
                        return _tab == 1 ? t.outgoing : (!t.outgoing && t.label.contains('Dividend'));
                      }
                      return _tab == 1 ? !t.outgoing : t.outgoing;
                    }).toList()[index];
                    
                    final isOutgoing = data.outgoing;
                    final statusOk = data.ok;
                    final amount = '${isOutgoing ? '-' : '+'} ${data.amount.toStringAsFixed(0)} ETB';
                    final amountColor = isOutgoing ? Colors.red[600] : Colors.green[600];
                    
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(index * 0.1, 1.0, curve: Curves.easeOutCubic),
                      )),
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: palette.cardBg,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Icon container
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: (statusOk ? Colors.green : Colors.red).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    _getTransactionIcon(data.label, isOutgoing),
                                    color: statusOk ? Colors.green[600] : Colors.red[600],
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Transaction details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.label,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: palette.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        data.party,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: palette.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: (statusOk ? Colors.green : Colors.red).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              statusOk ? 'Completed' : 'Failed',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: statusOk ? Colors.green[700] : Colors.red[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            data.date,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: palette.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Amount
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      amount,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: amountColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Icon(
                                      isOutgoing ? Icons.arrow_upward : Icons.arrow_downward,
                                      color: amountColor,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Txn {
  final String label;
  final bool ok;
  final bool outgoing; // true = money out
  final int amount;
  final String date;
  final String party;
  _Txn({required this.label, required this.ok, required this.outgoing, required this.amount, required this.date, required this.party});
}
