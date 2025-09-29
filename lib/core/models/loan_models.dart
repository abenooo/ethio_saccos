enum LoanType {
  personal,
  business,
  mortgage,
  auto,
}

enum LoanStatus {
  pending,
  approved,
  rejected,
  active,
  completed,
}

enum PaymentFrequency {
  monthly,
  quarterly,
  annually,
}

class LoanCalculationRequest {
  final LoanType loanType;
  final double loanAmount;
  final double interestRate;
  final int loanTermMonths;
  final PaymentFrequency paymentFrequency;
  final DateTime startDate;
  
  // Mortgage specific fields
  final double? homePrice;
  final double? downPayment;
  final bool? downPaymentIsPercentage;
  final double? propertyTax;
  final double? pmiAmount;
  final double? homeInsurance;
  final double? hoaFees;

  const LoanCalculationRequest({
    required this.loanType,
    required this.loanAmount,
    required this.interestRate,
    required this.loanTermMonths,
    required this.paymentFrequency,
    required this.startDate,
    this.homePrice,
    this.downPayment,
    this.downPaymentIsPercentage,
    this.propertyTax,
    this.pmiAmount,
    this.homeInsurance,
    this.hoaFees,
  });
}

class LoanCalculationResponse {
  final double monthlyPayment;
  final double totalPayment;
  final double totalInterest;
  final List<AmortizationEntry> amortizationSchedule;
  final DateTime calculatedAt;

  const LoanCalculationResponse({
    required this.monthlyPayment,
    required this.totalPayment,
    required this.totalInterest,
    required this.amortizationSchedule,
    required this.calculatedAt,
  });
}

enum PaymentStatus {
  paid,
  notPaid,
  overdue,
  pending,
}

class AmortizationEntry {
  final int paymentNumber;
  final DateTime paymentDate;
  final double paymentAmount;
  final double principalAmount;
  final double interestAmount;
  final double remainingBalance;
  final PaymentStatus paymentStatus;
  final DateTime? paidDate;
  final String? paymentMethod;

  const AmortizationEntry({
    required this.paymentNumber,
    required this.paymentDate,
    required this.paymentAmount,
    required this.principalAmount,
    required this.interestAmount,
    required this.remainingBalance,
    this.paymentStatus = PaymentStatus.notPaid,
    this.paidDate,
    this.paymentMethod,
  });

  AmortizationEntry copyWith({
    PaymentStatus? paymentStatus,
    DateTime? paidDate,
    String? paymentMethod,
  }) {
    return AmortizationEntry(
      paymentNumber: paymentNumber,
      paymentDate: paymentDate,
      paymentAmount: paymentAmount,
      principalAmount: principalAmount,
      interestAmount: interestAmount,
      remainingBalance: remainingBalance,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paidDate: paidDate ?? this.paidDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
