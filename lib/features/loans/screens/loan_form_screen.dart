import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_form_field.dart';
import '../../../core/theme/theme.dart';
import '../../../core/models/loan_models.dart';
import '../../../core/services/loan_calculation_service.dart';
import '../../../core/services/loan_history_service.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/utils/app_utils.dart';
import 'loan_details_screen.dart';

class LoanFormScreen extends StatefulWidget {
  final LoanType loanType;
  final String title;

  const LoanFormScreen({
    super.key,
    required this.loanType,
    required this.title,
  });

  @override
  State<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends State<LoanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Common fields
  final _loanAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _loanTermController = TextEditingController();
  final _startDateController = TextEditingController();
  
  // Mortgage specific fields
  final _homePriceController = TextEditingController();
  final _downPaymentController = TextEditingController();
  final _propertyTaxController = TextEditingController();
  final _pmiController = TextEditingController();
  final _homeInsuranceController = TextEditingController();
  final _hoaFeesController = TextEditingController();
  
  String _loanTermUnit = 'Years';
  bool _downPaymentIsPercentage = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startDateController.text = '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}';
    
    // Set default term unit based on loan type
    switch (widget.loanType) {
      case LoanType.personal:
        _loanTermUnit = 'Years';
        break;
      case LoanType.business:
        _loanTermUnit = 'Years';
        break;
      case LoanType.mortgage:
        _loanTermUnit = 'Years';
        break;
      case LoanType.auto:
        _loanTermUnit = 'Monthly';
        break;
    }
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _loanTermController.dispose();
    _startDateController.dispose();
    _homePriceController.dispose();
    _downPaymentController.dispose();
    _propertyTaxController.dispose();
    _pmiController.dispose();
    _homeInsuranceController.dispose();
    _hoaFeesController.dispose();
    super.dispose();
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
            title: widget.title,
            onBackPressed: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Required fields notice
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD97706)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Color(0xFFD97706), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            '(*) Must be fill',
                            style: TextStyle(
                              color: const Color(0xFFD97706),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Build form fields based on loan type
                    ..._buildFormFields(palette),
                    
                    const SizedBox(height: 32),
                    
                    // Calculate button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _calculateLoan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Calculate',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Reset button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _resetFields,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Reset field',
                          style: TextStyle(
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
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormFields(AppPalette palette) {
    switch (widget.loanType) {
      case LoanType.personal:
        return _buildPersonalLoanFields(palette);
      case LoanType.business:
        return _buildBusinessLoanFields(palette);
      case LoanType.mortgage:
        return _buildMortgageFields(palette);
      case LoanType.auto:
        return _buildAutoLoanFields(palette);
    }
  }

  List<Widget> _buildPersonalLoanFields(AppPalette palette) {
    return [
      CustomFormField(
        controller: _loanAmountController,
        label: 'Loan Amount',
        required: true,
        suffix: 'ETB',
        placeholder: '1,000,000',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyInputFormatter(),
        ],
        validator: (value) => InputValidators.validateAmount(value, minAmount: 10000),
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _interestRateController,
        label: 'Interest Rate',
        required: true,
        suffix: '%',
        placeholder: '15',
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      _buildLoanTermField(palette),
      const SizedBox(height: 16),
      _buildDateField(palette),
    ];
  }

  List<Widget> _buildBusinessLoanFields(AppPalette palette) {
    return [
      _buildTextField(
        controller: _loanAmountController,
        label: 'Loan Amount',
        required: true,
        suffix: '\$',
        keyboardType: TextInputType.number,
        isAmount: true,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _interestRateController,
        label: 'Interest Rate',
        required: true,
        suffix: '%',
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      _buildLoanTermField(palette),
    ];
  }

  List<Widget> _buildMortgageFields(AppPalette palette) {
    return [
      _buildTextField(
        controller: _homePriceController,
        label: 'Home Price',
        required: true,
        suffix: '\$',
        keyboardType: TextInputType.number,
        isAmount: true,
      ),
      const SizedBox(height: 16),
      _buildDownPaymentField(palette),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _interestRateController,
        label: 'Interest Rate',
        required: true,
        suffix: '%',
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _loanTermController,
        label: 'Loan Term',
        required: true,
        suffix: 'Years',
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: _buildTextField(
              controller: _propertyTaxController,
              label: 'Property Tax/Month',
              required: true,
              suffix: '\$',
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildTextField(
              controller: _pmiController,
              label: 'PMI/Month',
              required: true,
              suffix: '\$',
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: _buildTextField(
              controller: _homeInsuranceController,
              label: 'Home owner\'s insurance/Month',
              required: true,
              suffix: '\$',
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildTextField(
              controller: _hoaFeesController,
              label: 'HOA fees',
              required: true,
              suffix: '\$',
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildAutoLoanFields(AppPalette palette) {
    return [
      _buildTextField(
        controller: _loanAmountController,
        label: 'Loan Amount',
        required: true,
        suffix: '\$',
        keyboardType: TextInputType.number,
        isAmount: true,
      ),
      const SizedBox(height: 16),
      _buildLoanTermField(palette),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _interestRateController,
        label: 'Interest Rate',
        required: true,
        suffix: '%',
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      _buildDateField(palette),
    ];
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool required = false,
    String? suffix,
    String? placeholder,
    TextInputType? keyboardType,
    bool isAmount = false,
  }) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            children: required ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ] : null,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: isAmount ? [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ] : keyboardType == TextInputType.number ? [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ] : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.cardBg,
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: palette.textSecondary.withValues(alpha: 0.6),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
            ),
            suffixText: suffix,
            suffixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: palette.textSecondary,
            ),
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: palette.textPrimary,
          ),
          validator: required ? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          } : null,
        ),
      ],
    );
  }

  Widget _buildLoanTermField(AppPalette palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Loan Term',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: _loanTermController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: palette.cardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: palette.cardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: palette.cardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: palette.textPrimary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: _loanTermUnit,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: palette.cardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: palette.cardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: palette.cardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: palette.textPrimary,
                ),
                items: widget.loanType == LoanType.auto 
                  ? ['Monthly'].map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList()
                  : ['Years', 'Monthly'].map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList(),
                onChanged: (value) {
                  setState(() {
                    _loanTermUnit = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDownPaymentField(AppPalette palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Down Payment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: palette.textPrimary,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _downPaymentController,
                keyboardType: TextInputType.number,
                inputFormatters: !_downPaymentIsPercentage ? [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ] : [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixText: _downPaymentIsPercentage ? null : '\$ ',
                  suffixText: _downPaymentIsPercentage ? '%' : null,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField<bool>(
                value: _downPaymentIsPercentage,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: false, child: Text('\$')),
                  DropdownMenuItem(value: true, child: Text('%')),
                ],
                onChanged: (value) {
                  setState(() {
                    _downPaymentIsPercentage = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildDateField(AppPalette palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start Date',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: palette.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _startDateController,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.cardBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
            ),
            suffixIcon: Icon(
              Icons.calendar_today,
              color: palette.textSecondary,
            ),
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: palette.textPrimary,
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
            );
            if (date != null) {
              setState(() {
                _selectedDate = date;
                _startDateController.text = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
              });
            }
          },
        ),
      ],
    );
  }

  Future<void> _calculateLoan() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading
        AppUtils.showLoadingDialog(context, message: 'Calculating loan...');

        // Prepare loan request
        LoanCalculationRequest request;

        if (widget.loanType == LoanType.mortgage) {
          // Mortgage calculation
          final homePrice = double.parse(_homePriceController.text.replaceAll(',', ''));
          final downPayment = double.parse(_downPaymentController.text.replaceAll(',', ''));
          final interestRate = double.parse(_interestRateController.text);
          final loanTerm = int.parse(_loanTermController.text);
          final loanTermMonths = _loanTermUnit == 'Years' ? loanTerm * 12 : loanTerm;

          final actualLoanAmount = homePrice - (downPayment * (_downPaymentIsPercentage ? homePrice / 100 : 1));
          
          final response = LoanCalculationService.calculateMortgage(
            homePrice: homePrice,
            downPayment: downPayment,
            downPaymentIsPercentage: _downPaymentIsPercentage,
            interestRate: interestRate,
            loanTermMonths: loanTermMonths,
            startDate: _selectedDate,
            propertyTax: double.tryParse(_propertyTaxController.text.replaceAll(',', '')) ?? 0,
            pmiAmount: double.tryParse(_pmiController.text.replaceAll(',', '')) ?? 0,
            homeInsurance: double.tryParse(_homeInsuranceController.text.replaceAll(',', '')) ?? 0,
            hoaFees: double.tryParse(_hoaFeesController.text.replaceAll(',', '')) ?? 0,
          );

          // Save to history
          await LoanHistoryService.saveLoanCalculation(
            loanType: widget.loanType,
            loanAmount: actualLoanAmount,
            interestRate: interestRate,
            loanTermMonths: loanTermMonths,
            startDate: _selectedDate,
            response: response,
          );

          // Hide loading
          AppUtils.hideLoadingDialog(context);

          // Navigate to results
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoanDetailsScreen(
                title: widget.title,
                loanAmount: actualLoanAmount,
                interestRate: interestRate,
                loanTermMonths: loanTermMonths,
                startDate: _selectedDate,
              ),
            ),
          );
        } else {
          // Regular loan calculation
          final loanAmount = double.parse(_loanAmountController.text.replaceAll(',', ''));
          final interestRate = double.parse(_interestRateController.text);
          final loanTerm = int.parse(_loanTermController.text);
          final loanTermMonths = _loanTermUnit == 'Years' ? loanTerm * 12 : loanTerm;

          request = LoanCalculationRequest(
            loanType: widget.loanType,
            loanAmount: loanAmount,
            interestRate: interestRate,
            loanTermMonths: loanTermMonths,
            paymentFrequency: PaymentFrequency.monthly,
            startDate: _selectedDate,
          );

          final response = LoanCalculationService.calculateLoan(request);

          // Save to history
          await LoanHistoryService.saveLoanCalculation(
            loanType: widget.loanType,
            loanAmount: loanAmount,
            interestRate: interestRate,
            loanTermMonths: loanTermMonths,
            startDate: _selectedDate,
            response: response,
          );

          // Hide loading
          AppUtils.hideLoadingDialog(context);

          // Navigate to results
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoanDetailsScreen(
                title: widget.title,
                loanAmount: loanAmount,
                interestRate: interestRate,
                loanTermMonths: loanTermMonths,
                startDate: _selectedDate,
              ),
            ),
          );
        }

        // Show success message
        AppUtils.showSnackBar(
          context,
          'Loan calculation completed successfully!',
          type: SnackBarType.success,
        );

      } catch (e) {
        // Hide loading if still showing
        Navigator.of(context).popUntil((route) => route.isFirst);
        
        // Show error message
        AppUtils.showSnackBar(
          context,
          'Error calculating loan: ${e.toString()}',
          type: SnackBarType.error,
        );
      }
    }
  }

  void _resetFields() {
    _loanAmountController.clear();
    _interestRateController.clear();
    _loanTermController.clear();
    _homePriceController.clear();
    _downPaymentController.clear();
    _propertyTaxController.clear();
    _pmiController.clear();
    _homeInsuranceController.clear();
    _hoaFeesController.clear();
    
    setState(() {
      _loanTermUnit = 'Years';
      _downPaymentIsPercentage = false;
      _selectedDate = DateTime.now();
      _startDateController.text = '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}';
    });
  }
}
