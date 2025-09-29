import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/theme/theme.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double amount;
  final String loanTitle;
  final int paymentNumber;
  final Function(String paymentMethod) onPaymentCompleted;

  const PaymentMethodScreen({
    super.key,
    required this.amount,
    required this.loanTitle,
    required this.paymentNumber,
    required this.onPaymentCompleted,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedMethod;

  final List<PaymentMethod> _ethiopianPaymentMethods = [
    // Mobile Money/Digital Wallets
    PaymentMethod(
      id: 'telebirr',
      name: 'TeleBirr',
      description: 'Pay with TeleBirr mobile wallet',
      icon: Icons.phone_android,
      color: Color(0xFF00A651),
      type: PaymentType.mobileWallet,
    ),
    PaymentMethod(
      id: 'mpesa',
      name: 'M-PESA',
      description: 'Pay with Safaricom M-PESA',
      icon: Icons.phone_android,
      color: Color(0xFF00A651),
      type: PaymentType.mobileWallet,
    ),
    PaymentMethod(
      id: 'hellocash',
      name: 'HelloCash',
      description: 'Pay with HelloCash wallet',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF1976D2),
      type: PaymentType.mobileWallet,
    ),
    
    // Ethiopian Banks
    PaymentMethod(
      id: 'cbe',
      name: 'Commercial Bank of Ethiopia',
      description: 'CBE Mobile & Internet Banking',
      icon: Icons.account_balance,
      color: Color(0xFF1E3A8A),
      type: PaymentType.bank,
    ),
    PaymentMethod(
      id: 'dashen',
      name: 'Dashen Bank',
      description: 'DashPay Mobile Banking',
      icon: Icons.account_balance,
      color: Color(0xFF8B0000),
      type: PaymentType.bank,
    ),
    PaymentMethod(
      id: 'awash',
      name: 'Awash Bank',
      description: 'Awash Mobile Banking',
      icon: Icons.account_balance,
      color: Color(0xFF006400),
      type: PaymentType.bank,
    ),
    PaymentMethod(
      id: 'boa',
      name: 'Bank of Abyssinia',
      description: 'BOA Mobile Banking',
      icon: Icons.account_balance,
      color: Color(0xFF4B0082),
      type: PaymentType.bank,
    ),
    PaymentMethod(
      id: 'wegagen',
      name: 'Wegagen Bank',
      description: 'Wegagen Mobile Banking',
      icon: Icons.account_balance,
      color: Color(0xFF228B22),
      type: PaymentType.bank,
    ),
    PaymentMethod(
      id: 'nib',
      name: 'Nib International Bank',
      description: 'NIB Mobile Banking',
      icon: Icons.account_balance,
      color: Color(0xFFFF6B35),
      type: PaymentType.bank,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Payment Method',
            onBackPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Summary
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: palette.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: palette.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Summary',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow('Loan', widget.loanTitle, palette),
                        const SizedBox(height: 8),
                        _buildSummaryRow('Payment #', '${widget.paymentNumber}', palette),
                        const SizedBox(height: 8),
                        _buildSummaryRow('Amount', '${widget.amount.toStringAsFixed(2)} ETB', palette, isAmount: true),
                        const SizedBox(height: 8),
                        _buildSummaryRow('Penalty', '0.00 ETB', palette, isAmount: true),
                        Divider(height: 24, color: palette.cardBorder),
                        _buildSummaryRow('Total', '${widget.amount.toStringAsFixed(2)} ETB', palette, isAmount: true, isTotal: true),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Mobile Wallets Section
                  Text(
                    'Mobile Wallets',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: palette.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  ..._ethiopianPaymentMethods
                      .where((method) => method.type == PaymentType.mobileWallet)
                      .map((method) => _buildPaymentMethodCard(method, palette)),
                  
                  const SizedBox(height: 24),
                  
                  // Banks Section
                  Text(
                    'Ethiopian Banks',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: palette.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  ..._ethiopianPaymentMethods
                      .where((method) => method.type == PaymentType.bank)
                      .map((method) => _buildPaymentMethodCard(method, palette)),
                  
                  const SizedBox(height: 32),
                  
                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedMethod != null ? _processPayment : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _selectedMethod != null 
                          ? 'Pay ${widget.amount.toStringAsFixed(2)} ETB'
                          : 'Select Payment Method',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, AppPalette palette, {bool isAmount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? palette.textPrimary : palette.textSecondary,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal 
                ? Theme.of(context).colorScheme.primary 
                : isAmount 
                    ? Theme.of(context).colorScheme.primary 
                    : palette.textPrimary,
            fontSize: isTotal ? 18 : isAmount ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : isAmount ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method, AppPalette palette) {
    final isSelected = _selectedMethod == method.id;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = method.id),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: palette.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Theme.of(context).colorScheme.primary : palette.cardBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: method.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  method.icon,
                  color: method.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.name,
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      method.description,
                      style: TextStyle(
                        color: palette.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment() {
    if (_selectedMethod == null) return;
    
    final selectedMethod = _ethiopianPaymentMethods.firstWhere(
      (method) => method.id == _selectedMethod,
    );
    
    // Show awesome payment processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildProcessingDialog(selectedMethod),
    );
    
    // Simulate payment processing with stages
    _simulatePaymentStages(selectedMethod);
  }

  void _simulatePaymentStages(PaymentMethod selectedMethod) async {
    // Stage 1: Connecting (1 second)
    await Future.delayed(const Duration(seconds: 1));
    
    // Stage 2: Authenticating (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Stage 3: Processing (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));
    
    Navigator.pop(context); // Close processing dialog
    
    // Show awesome success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildSuccessDialog(selectedMethod),
    );
  }

  Widget _buildProcessingDialog(PaymentMethod selectedMethod) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              selectedMethod.color.withValues(alpha: 0.1),
              selectedMethod.color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated payment icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedMethod.color.withValues(alpha: 0.1),
                border: Border.all(color: selectedMethod.color.withValues(alpha: 0.3), width: 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating border animation
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(selectedMethod.color),
                    ),
                  ),
                  // Payment method icon
                  Icon(
                    selectedMethod.icon,
                    color: selectedMethod.color,
                    size: 32,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Processing title
            Text(
              'Processing Payment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).extension<AppPalette>()!.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            
            // Payment method name
            Text(
              'via ${selectedMethod.name}',
              style: TextStyle(
                fontSize: 16,
                color: selectedMethod.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Amount
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selectedMethod.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: selectedMethod.color.withValues(alpha: 0.3)),
              ),
              child: Text(
                '${widget.amount.toStringAsFixed(2)} ETB',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: selectedMethod.color,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Processing stages
            _buildProcessingStages(),
            
            const SizedBox(height: 16),
            Text(
              'Please wait while we process your payment...',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).extension<AppPalette>()!.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingStages() {
    return Column(
      children: [
        _buildStageItem('Connecting to ${_ethiopianPaymentMethods.firstWhere((m) => m.id == _selectedMethod).name}', true),
        _buildStageItem('Authenticating payment', false),
        _buildStageItem('Processing transaction', false),
      ],
    );
  }

  Widget _buildStageItem(String title, bool isActive) {
    final selectedMethod = _ethiopianPaymentMethods.firstWhere((m) => m.id == _selectedMethod);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? selectedMethod.color : Colors.grey.withValues(alpha: 0.3),
            ),
            child: isActive
                ? SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isActive ? selectedMethod.color : Colors.grey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessDialog(PaymentMethod selectedMethod) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF059669).withValues(alpha: 0.1),
              const Color(0xFF059669).withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success animation
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF059669).withValues(alpha: 0.1),
                border: Border.all(color: const Color(0xFF059669), width: 2),
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF059669),
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            
            // Success title
            const Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF059669),
              ),
            ),
            const SizedBox(height: 16),
            
            // Payment details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF059669).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF059669).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  _buildSuccessDetailRow('Amount', '${widget.amount.toStringAsFixed(2)} ETB'),
                  const SizedBox(height: 8),
                  _buildSuccessDetailRow('Payment Method', selectedMethod.name),
                  const SizedBox(height: 8),
                  _buildSuccessDetailRow('Transaction ID', 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}'),
                  const SizedBox(height: 8),
                  _buildSuccessDetailRow('Date', '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement receipt download/share
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF059669)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Receipt',
                      style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close success dialog
                      Navigator.pop(context); // Go back to loan details
                      widget.onPaymentCompleted(selectedMethod.name);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF059669),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF059669),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

enum PaymentType {
  bank,
  mobileWallet,
}

class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final PaymentType type;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.type,
  });
}
