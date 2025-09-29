import 'dart:math' as math;
import '../models/loan_models.dart';

/// Service for performing loan calculations locally without API dependencies.
/// 
/// This service provides comprehensive loan calculation functionality including:
/// - Monthly payment calculations using PMT formula
/// - Complete amortization schedule generation
/// - Mortgage-specific calculations with additional costs
/// - Loan type validation and limits
/// 
/// All calculations are performed locally for privacy and performance.
class LoanCalculationService {
  static LoanCalculationResponse calculateLoan(LoanCalculationRequest request) {
    final monthlyRate = request.interestRate / 100 / 12;
    final monthlyPayment = _calculateMonthlyPayment(
      principal: request.loanAmount,
      monthlyRate: monthlyRate,
      loanTermMonths: request.loanTermMonths,
    );

    final amortizationSchedule = _generateAmortizationSchedule(
      principal: request.loanAmount,
      monthlyPayment: monthlyPayment,
      monthlyRate: monthlyRate,
      loanTermMonths: request.loanTermMonths,
      startDate: request.startDate,
    );

    final totalPayment = monthlyPayment * request.loanTermMonths;
    final totalInterest = totalPayment - request.loanAmount;

    return LoanCalculationResponse(
      monthlyPayment: monthlyPayment,
      totalPayment: totalPayment,
      totalInterest: totalInterest,
      amortizationSchedule: amortizationSchedule,
      calculatedAt: DateTime.now(),
    );
  }

  static double _calculateMonthlyPayment({
    required double principal,
    required double monthlyRate,
    required int loanTermMonths,
  }) {
    if (monthlyRate == 0) {
      return principal / loanTermMonths;
    }

    final numerator = principal * monthlyRate * math.pow(1 + monthlyRate, loanTermMonths);
    final denominator = math.pow(1 + monthlyRate, loanTermMonths) - 1;
    
    return numerator / denominator;
  }

  static List<AmortizationEntry> _generateAmortizationSchedule({
    required double principal,
    required double monthlyPayment,
    required double monthlyRate,
    required int loanTermMonths,
    required DateTime startDate,
  }) {
    final schedule = <AmortizationEntry>[];
    double remainingBalance = principal;

    for (int i = 1; i <= loanTermMonths; i++) {
      final interestAmount = remainingBalance * monthlyRate;
      final principalAmount = monthlyPayment - interestAmount;
      remainingBalance = math.max(0, remainingBalance - principalAmount);

      final paymentDate = DateTime(
        startDate.year,
        startDate.month + i,
        startDate.day,
      );

      schedule.add(AmortizationEntry(
        paymentNumber: i,
        paymentDate: paymentDate,
        paymentAmount: monthlyPayment,
        principalAmount: principalAmount,
        interestAmount: interestAmount,
        remainingBalance: remainingBalance,
      ));
    }

    return schedule;
  }

  static LoanCalculationResponse calculateMortgage({
    required double homePrice,
    required double downPayment,
    required bool downPaymentIsPercentage,
    required double interestRate,
    required int loanTermMonths,
    required DateTime startDate,
    double propertyTax = 0,
    double pmiAmount = 0,
    double homeInsurance = 0,
    double hoaFees = 0,
  }) {
    final actualDownPayment = downPaymentIsPercentage
        ? homePrice * (downPayment / 100)
        : downPayment;

    // Calculate loan amount
    final loanAmount = homePrice - actualDownPayment;

    // Create loan request
    final request = LoanCalculationRequest(
      loanType: LoanType.mortgage,
      loanAmount: loanAmount,
      interestRate: interestRate,
      loanTermMonths: loanTermMonths,
      paymentFrequency: PaymentFrequency.monthly,
      startDate: startDate,
      homePrice: homePrice,
      downPayment: actualDownPayment,
      downPaymentIsPercentage: downPaymentIsPercentage,
      propertyTax: propertyTax,
      pmiAmount: pmiAmount,
      homeInsurance: homeInsurance,
      hoaFees: hoaFees,
    );

    // Calculate base loan
    final baseCalculation = calculateLoan(request);

    // Add additional monthly costs for mortgage
    final totalMonthlyPayment = baseCalculation.monthlyPayment + 
        propertyTax + pmiAmount + homeInsurance + hoaFees;

    return LoanCalculationResponse(
      monthlyPayment: totalMonthlyPayment,
      totalPayment: baseCalculation.totalPayment + 
          (propertyTax + pmiAmount + homeInsurance + hoaFees) * loanTermMonths,
      totalInterest: baseCalculation.totalInterest,
      amortizationSchedule: baseCalculation.amortizationSchedule,
      calculatedAt: DateTime.now(),
    );
  }

  // Get loan type specific limits and defaults
  static LoanTypeLimits getLoanTypeLimits(LoanType loanType) {
    switch (loanType) {
      case LoanType.personal:
        return const LoanTypeLimits(
          minAmount: 10000,
          maxAmount: 5000000,
          minInterestRate: 8.0,
          maxInterestRate: 25.0,
          minTermMonths: 6,
          maxTermMonths: 120,
          defaultInterestRate: 15.0,
          defaultTermMonths: 60,
        );
      case LoanType.business:
        return const LoanTypeLimits(
          minAmount: 50000,
          maxAmount: 20000000,
          minInterestRate: 10.0,
          maxInterestRate: 20.0,
          minTermMonths: 12,
          maxTermMonths: 240,
          defaultInterestRate: 12.0,
          defaultTermMonths: 120,
        );
      case LoanType.mortgage:
        return const LoanTypeLimits(
          minAmount: 500000,
          maxAmount: 50000000,
          minInterestRate: 6.0,
          maxInterestRate: 15.0,
          minTermMonths: 120,
          maxTermMonths: 360,
          defaultInterestRate: 8.5,
          defaultTermMonths: 300,
        );
      case LoanType.auto:
        return const LoanTypeLimits(
          minAmount: 100000,
          maxAmount: 10000000,
          minInterestRate: 7.0,
          maxInterestRate: 18.0,
          minTermMonths: 12,
          maxTermMonths: 84,
          defaultInterestRate: 10.0,
          defaultTermMonths: 60,
        );
    }
  }

  // Get loan type display information
  static LoanTypeInfo getLoanTypeInfo(LoanType loanType) {
    switch (loanType) {
      case LoanType.personal:
        return const LoanTypeInfo(
          title: 'Personal Loan',
          description: 'Quick personal financing for your needs',
          features: [
            'No collateral required',
            'Quick approval process',
            'Flexible repayment terms',
            'Competitive interest rates',
          ],
        );
      case LoanType.business:
        return const LoanTypeInfo(
          title: 'Business Loan',
          description: 'Grow your business with our financing solutions',
          features: [
            'Business expansion funding',
            'Working capital support',
            'Equipment financing',
            'Flexible payment schedules',
          ],
        );
      case LoanType.mortgage:
        return const LoanTypeInfo(
          title: 'Mortgage Loan',
          description: 'Home financing made simple',
          features: [
            'Home purchase financing',
            'Competitive mortgage rates',
            'Long-term repayment options',
            'Professional guidance',
          ],
        );
      case LoanType.auto:
        return const LoanTypeInfo(
          title: 'Auto Loan',
          description: 'Vehicle financing solutions',
          features: [
            'New and used car financing',
            'Quick approval process',
            'Competitive rates',
            'Flexible terms',
          ],
        );
    }
  }
}

class LoanTypeLimits {
  final double minAmount;
  final double maxAmount;
  final double minInterestRate;
  final double maxInterestRate;
  final int minTermMonths;
  final int maxTermMonths;
  final double defaultInterestRate;
  final int defaultTermMonths;

  const LoanTypeLimits({
    required this.minAmount,
    required this.maxAmount,
    required this.minInterestRate,
    required this.maxInterestRate,
    required this.minTermMonths,
    required this.maxTermMonths,
    required this.defaultInterestRate,
    required this.defaultTermMonths,
  });
}

class LoanTypeInfo {
  final String title;
  final String description;
  final List<String> features;

  const LoanTypeInfo({
    required this.title,
    required this.description,
    required this.features,
  });
}
