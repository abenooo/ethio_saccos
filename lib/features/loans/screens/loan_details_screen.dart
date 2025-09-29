import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/theme/theme.dart';
import '../../../core/models/loan_models.dart';
import '../../payments/screens/payment_method_screen.dart';

class LoanDetailsScreen extends StatefulWidget {
  final String title;
  final double loanAmount;
  final double interestRate;
  final int loanTermMonths;
  final DateTime startDate;

  LoanDetailsScreen({
    super.key,
    required this.title,
    this.loanAmount = 50000,
    this.interestRate = 12.0,
    this.loanTermMonths = 24,
    DateTime? startDate,
  }) : startDate = startDate ?? DateTime(2023, 1, 1);

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen>
    with TickerProviderStateMixin {
  bool _showAmortizationTable = false;
  late List<AmortizationEntry> _amortizationSchedule;
  late double _monthlyPayment;

  @override
  void initState() {
    super.initState();
    _calculateAmortization();
  }

  void _calculateAmortization() {
    final monthlyRate = widget.interestRate / 100 / 12;
    final numPayments = widget.loanTermMonths;
    
    // Calculate monthly payment using PMT formula
    _monthlyPayment = widget.loanAmount * 
        (monthlyRate * math.pow(1 + monthlyRate, numPayments)) /
        (math.pow(1 + monthlyRate, numPayments) - 1);

    _amortizationSchedule = [];
    double remainingBalance = widget.loanAmount;
    final currentDate = DateTime.now();

    for (int month = 1; month <= numPayments; month++) {
      final interestPayment = remainingBalance * monthlyRate;
      final principalPayment = _monthlyPayment - interestPayment;
      remainingBalance -= principalPayment;

      final paymentDate = DateTime(
        widget.startDate.year,
        widget.startDate.month + month - 1,
      );

      // Determine payment status based on date and simulate some payments
      PaymentStatus status;
      DateTime? paidDate;
      String? paymentMethod;
      
      if (paymentDate.isBefore(currentDate)) {
        // For demo purposes, mark first 3 payments as paid
        if (month <= 3) {
          status = PaymentStatus.paid;
          paidDate = paymentDate;
          paymentMethod = month == 1 ? 'TeleBirr' : month == 2 ? 'CBE Mobile' : 'Dashen Bank';
        } else if (paymentDate.isBefore(currentDate.subtract(const Duration(days: 30)))) {
          status = PaymentStatus.overdue;
        } else {
          status = PaymentStatus.notPaid;
        }
      } else {
        status = PaymentStatus.notPaid;
      }

      _amortizationSchedule.add(AmortizationEntry(
        paymentNumber: month,
        paymentDate: paymentDate,
        paymentAmount: _monthlyPayment,
        principalAmount: principalPayment,
        interestAmount: interestPayment,
        remainingBalance: remainingBalance > 0 ? remainingBalance : 0,
        paymentStatus: status,
        paidDate: paidDate,
        paymentMethod: paymentMethod,
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Result',
            onBackPressed: () {
              if (_showAmortizationTable) {
                setState(() => _showAmortizationTable = false);
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          Expanded(
            child: _showAmortizationTable 
              ? _buildAmortizationTableView()
              : _buildSummaryView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryView() {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final totalInterest = _amortizationSchedule.fold<double>(
      0, (sum, entry) => sum + entry.interestAmount);
    final totalPayments = _monthlyPayment * widget.loanTermMonths;
    final endDate = _amortizationSchedule.last.paymentDate;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // First section - Basic loan info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: palette.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: palette.cardBorder),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Loan Amount', '${widget.loanAmount.toStringAsFixed(0)} ETB', palette),
                const SizedBox(height: 16),
                _buildSummaryRow('Interest Rate', '${widget.interestRate} %', palette),
                const SizedBox(height: 16),
                _buildSummaryRow('Loan Term', '${(widget.loanTermMonths / 12).toStringAsFixed(0)} years', palette),
                const SizedBox(height: 16),
                _buildSummaryRow('Start Date', '${widget.startDate.day.toString().padLeft(2, '0')}/${widget.startDate.month.toString().padLeft(2, '0')}/${widget.startDate.year}', palette),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Result section header
          Row(
            children: [
              Text(
                'Result',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: palette.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Second section - Results
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: palette.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: palette.cardBorder),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Monthly Payment', '${_monthlyPayment.toStringAsFixed(2)} ETB', palette),
                const SizedBox(height: 16),
                _buildSummaryRow('Total payments', '${totalPayments.toStringAsFixed(0)} ETB', palette),
                const SizedBox(height: 16),
                _buildSummaryRow('Total Interest Paid', '${totalInterest.toStringAsFixed(0)} ETB', palette),
                const SizedBox(height: 16),
                _buildSummaryRow('Pay-off date', '${endDate.day.toString().padLeft(2, '0')}/${endDate.month.toString().padLeft(2, '0')}/${endDate.year}', palette),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // View Amortization Table button
          GestureDetector(
            onTap: () => setState(() => _showAmortizationTable = true),
            child: Text(
              'View Amortization Table',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 100), // Space for bottom button
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, AppPalette palette) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: palette.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: palette.textPrimary,
          ),
        ),
      ],
    );
  }



  Widget _buildAmortizationTableView() {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final totalInterest = _amortizationSchedule.fold<double>(
      0, (sum, entry) => sum + entry.interestAmount);
    final totalPayments = _monthlyPayment * widget.loanTermMonths;
    final endDate = _amortizationSchedule.last.paymentDate;

    return Column(
      children: [
        // Summary section at top (compact version)
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: palette.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: palette.cardBorder),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildCompactSummaryItem('Loan Amount', '${widget.loanAmount.toStringAsFixed(0)} ETB', palette)),
                  Expanded(child: _buildCompactSummaryItem('Monthly Payment', '${_monthlyPayment.toStringAsFixed(2)} ETB', palette)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildCompactSummaryItem('Interest Rate', '${widget.interestRate} %', palette)),
                  Expanded(child: _buildCompactSummaryItem('Total payments', '${totalPayments.toStringAsFixed(0)} ETB', palette)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildCompactSummaryItem('Loan Term', '${(widget.loanTermMonths / 12).toStringAsFixed(0)} years', palette)),
                  Expanded(child: _buildCompactSummaryItem('Total Interest Paid', '${totalInterest.toStringAsFixed(0)} ETB', palette)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildCompactSummaryItem('Start Date', '${widget.startDate.day.toString().padLeft(2, '0')}/${widget.startDate.month.toString().padLeft(2, '0')}/${widget.startDate.year}', palette)),
                  Expanded(child: _buildCompactSummaryItem('Pay-off date', '${endDate.day.toString().padLeft(2, '0')}/${endDate.month.toString().padLeft(2, '0')}/${endDate.year}', palette)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Result section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Payment Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: palette.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Table
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(4, 0, 4, 16),
            decoration: BoxDecoration(
              color: palette.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.cardBorder),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Table header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text('#', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 3, child: Text('Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 3, child: Text('Interest', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 3, child: Text('Principal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 3, child: Text('Balance', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 3, child: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 2, child: Text('Action', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                // Table rows
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 8,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _amortizationSchedule.length,
                        itemBuilder: (context, index) {
                          final entry = _amortizationSchedule[index];
                          final isEven = index % 2 == 0;
                          final itemPalette = Theme.of(context).extension<AppPalette>()!;

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            decoration: BoxDecoration(
                              color: isEven ? itemPalette.cardBg : itemPalette.sectionBg,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${entry.paymentNumber}', style: TextStyle(fontSize: 12, color: itemPalette.textPrimary), textAlign: TextAlign.center)),
                                Expanded(flex: 3, child: Text(entry.paymentAmount.toStringAsFixed(0), style: TextStyle(fontSize: 12, color: itemPalette.textPrimary), textAlign: TextAlign.center)),
                                Expanded(flex: 3, child: Text(entry.interestAmount.toStringAsFixed(0), style: TextStyle(fontSize: 12, color: itemPalette.textPrimary), textAlign: TextAlign.center)),
                                Expanded(flex: 3, child: Text(entry.principalAmount.toStringAsFixed(0), style: TextStyle(fontSize: 12, color: itemPalette.textPrimary), textAlign: TextAlign.center)),
                                Expanded(flex: 3, child: Text(entry.remainingBalance.toStringAsFixed(0), style: TextStyle(fontSize: 12, color: itemPalette.textPrimary), textAlign: TextAlign.center)),
                                Expanded(flex: 3, child: Center(child: _buildPaymentStatus(entry, itemPalette))),
                                const SizedBox(width: 8),
                                Expanded(flex: 2, child: Center(child: _buildActionButton(entry, itemPalette))),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatus(AmortizationEntry entry, AppPalette palette) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (entry.paymentStatus) {
      case PaymentStatus.paid:
        statusColor = const Color(0xFF059669); // Success Green
        statusText = 'Paid';
        statusIcon = Icons.check_circle;
        break;
      case PaymentStatus.overdue:
        statusColor = const Color(0xFFDC2626); // Error Red
        statusText = 'Overdue';
        statusIcon = Icons.error;
        break;
      case PaymentStatus.pending:
        statusColor = const Color(0xFFD97706); // Accent Gold
        statusText = 'Pending';
        statusIcon = Icons.schedule;
        break;
      case PaymentStatus.notPaid:
        statusColor = palette.textSecondary;
        statusText = 'Due';
        statusIcon = Icons.radio_button_unchecked;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Icon(statusIcon, color: statusColor, size: 12),
    );
  }

  Widget _buildActionButton(AmortizationEntry entry, AppPalette palette) {
    if (entry.paymentStatus == PaymentStatus.paid) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF059669).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF059669).withValues(alpha: 0.3), width: 1),
        ),
        child: Icon(
          Icons.check,
          color: const Color(0xFF059669),
          size: 12,
        ),
      );
    }

    if (entry.paymentStatus == PaymentStatus.notPaid || entry.paymentStatus == PaymentStatus.overdue) {
      return InkWell(
        onTap: () => _navigateToPayment(entry),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3), width: 1),
          ),
          child: Icon(
            Icons.payment,
            color: Theme.of(context).colorScheme.primary,
            size: 12,
          ),
        ),
      );
    }

    return Icon(
      Icons.remove,
      color: palette.textSecondary,
      size: 12,
    );
  }

  void _navigateToPayment(AmortizationEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodScreen(
          amount: entry.paymentAmount,
          loanTitle: widget.title,
          paymentNumber: entry.paymentNumber,
          onPaymentCompleted: (paymentMethod) {
            setState(() {
              final index = _amortizationSchedule.indexWhere(
                (e) => e.paymentNumber == entry.paymentNumber,
              );
              if (index != -1) {
                _amortizationSchedule[index] = entry.copyWith(
                  paymentStatus: PaymentStatus.paid,
                  paidDate: DateTime.now(),
                  paymentMethod: paymentMethod,
                );
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildCompactSummaryItem(String label, String value, AppPalette palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: palette.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: palette.textPrimary,
          ),
        ),
      ],
    );
  }
}
