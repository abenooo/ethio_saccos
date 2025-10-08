import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_om.dart';
import 'app_localizations_so.dart';
import 'app_localizations_ti.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('om'),
    Locale('so'),
    Locale('ti'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'SACCOS Ethiopia'**
  String get appTitle;

  /// Welcome message on home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcomeBack;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign in with biometric button text
  ///
  /// In en, this message translates to:
  /// **'Sign in with {biometricType}'**
  String signInWithBiometric(String biometricType);

  /// Email address label
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Don't have account text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Full name label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Phone number label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Confirm password label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Already have account text
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// My accounts menu item
  ///
  /// In en, this message translates to:
  /// **'My Accounts'**
  String get myAccounts;

  /// Loan calculator title
  ///
  /// In en, this message translates to:
  /// **'Loan Calculator'**
  String get loanCalculator;

  /// Statements menu item
  ///
  /// In en, this message translates to:
  /// **'Statements'**
  String get statements;

  /// Deposit menu item
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// Withdraw menu item
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// Transfer menu item
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Profile screen title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Notifications menu item
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Security and support section
  ///
  /// In en, this message translates to:
  /// **'Security & Support'**
  String get security;

  /// Biometric authentication setting
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get biometricAuthentication;

  /// Biometric enabled status
  ///
  /// In en, this message translates to:
  /// **'{biometricType} enabled'**
  String biometricEnabled(String biometricType);

  /// Biometric disabled status
  ///
  /// In en, this message translates to:
  /// **'{biometricType} disabled'**
  String biometricDisabled(String biometricType);

  /// Change password menu item
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Help center menu
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Balance label
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// Main account label
  ///
  /// In en, this message translates to:
  /// **'Main Account'**
  String get mainAccount;

  /// Personal loan label
  ///
  /// In en, this message translates to:
  /// **'Personal Loan'**
  String get personalLoan;

  /// Share account label
  ///
  /// In en, this message translates to:
  /// **'Share Account'**
  String get shareAccount;

  /// OR separator text
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// Demo credentials header
  ///
  /// In en, this message translates to:
  /// **'Demo Credentials'**
  String get demoCredentials;

  /// Demo credentials description
  ///
  /// In en, this message translates to:
  /// **'Use any email and password to login'**
  String get useAnyEmailPassword;

  /// Demo credentials example
  ///
  /// In en, this message translates to:
  /// **'Example: user@example.com / password123'**
  String get example;

  /// Vibration setting
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// Enabled status
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// Disabled status
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// Push notifications setting
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// Email notifications setting
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// Weekly summary setting
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get weeklySum;

  /// Last changed time
  ///
  /// In en, this message translates to:
  /// **'Last changed {time}'**
  String lastChanged(String time);

  /// Two-factor authentication setting
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuth;

  /// FAQs and support subtitle
  ///
  /// In en, this message translates to:
  /// **'FAQs and support'**
  String get faqsAndSupport;

  /// Contact support menu
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// About SACCO menu
  ///
  /// In en, this message translates to:
  /// **'About SACCO'**
  String get aboutSacco;

  /// Privacy and security menu item
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// Font size setting
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// Medium font size
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Light mode setting
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Account preferences section
  ///
  /// In en, this message translates to:
  /// **'Account & Preferences'**
  String get accountPreferences;

  /// Support section header
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get support;

  /// Regular savings account
  ///
  /// In en, this message translates to:
  /// **'Regular Savings'**
  String get regularSavings;

  /// Fixed deposit account
  ///
  /// In en, this message translates to:
  /// **'Fixed Deposit 12M'**
  String get fixedDeposit;

  /// Emergency fund account
  ///
  /// In en, this message translates to:
  /// **'Emergency Fund'**
  String get emergencyFund;

  /// Children education savings
  ///
  /// In en, this message translates to:
  /// **'Children Education'**
  String get childrenEducation;

  /// Holiday savings account
  ///
  /// In en, this message translates to:
  /// **'Holiday Savings'**
  String get holidaySavings;

  /// Account details subtitle
  ///
  /// In en, this message translates to:
  /// **'View balances & details'**
  String get viewBalancesDetails;

  /// Loan calculator subtitle
  ///
  /// In en, this message translates to:
  /// **'Calculate payments'**
  String get calculatePayments;

  /// Statements subtitle
  ///
  /// In en, this message translates to:
  /// **'Download & view'**
  String get downloadView;

  /// Deposit subtitle
  ///
  /// In en, this message translates to:
  /// **'Add funds'**
  String get addFunds;

  /// Withdraw subtitle
  ///
  /// In en, this message translates to:
  /// **'Cash withdrawal'**
  String get cashWithdrawal;

  /// Transfer subtitle
  ///
  /// In en, this message translates to:
  /// **'Send money'**
  String get sendMoney;

  /// Profile subtitle
  ///
  /// In en, this message translates to:
  /// **'View and edit profile'**
  String get viewEditProfile;

  /// Personal loan subtitle
  ///
  /// In en, this message translates to:
  /// **'Quick personal financing'**
  String get quickPersonalFinancing;

  /// Business loan subtitle
  ///
  /// In en, this message translates to:
  /// **'Grow your business'**
  String get growYourBusiness;

  /// Mortgage loan subtitle
  ///
  /// In en, this message translates to:
  /// **'Home financing'**
  String get homeFinancing;

  /// Auto loan subtitle
  ///
  /// In en, this message translates to:
  /// **'Vehicle financing'**
  String get vehicleFinancing;

  /// Business loan calculator
  ///
  /// In en, this message translates to:
  /// **'Business Loan'**
  String get businessLoan;

  /// Mortgage loan calculator
  ///
  /// In en, this message translates to:
  /// **'Mortgages Loan'**
  String get mortgagesLoan;

  /// Auto loan calculator
  ///
  /// In en, this message translates to:
  /// **'Auto Loan'**
  String get autoLoan;

  /// Pay to merchant service
  ///
  /// In en, this message translates to:
  /// **'Pay to Merchant'**
  String get payToMerchant;

  /// Payment request service
  ///
  /// In en, this message translates to:
  /// **'Payment Request'**
  String get paymentRequest;

  /// Ticket service
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// Government services
  ///
  /// In en, this message translates to:
  /// **'Government Services'**
  String get governmentServices;

  /// Pay for service
  ///
  /// In en, this message translates to:
  /// **'Pay for'**
  String get payFor;

  /// Donations service
  ///
  /// In en, this message translates to:
  /// **'Donations'**
  String get donations;

  /// Other services
  ///
  /// In en, this message translates to:
  /// **'Other Services'**
  String get otherServices;

  /// Scan QR code
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQr;

  /// Home navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Accounts navigation
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// Loans navigation
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get loans;

  /// More navigation
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// Savings navigation
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// Savings account title
  ///
  /// In en, this message translates to:
  /// **'Savings Account'**
  String get savingsAccount;

  /// Savings account description
  ///
  /// In en, this message translates to:
  /// **'Manage your savings, view interest and deposits'**
  String get manageSavings;

  /// Loan services title
  ///
  /// In en, this message translates to:
  /// **'Loan Services'**
  String get loanServices;

  /// Loan services description
  ///
  /// In en, this message translates to:
  /// **'Apply for loans, view loan status and payments'**
  String get applyLoans;

  /// New user sign up text
  ///
  /// In en, this message translates to:
  /// **'I\'m a new user. Sign up'**
  String get newUserSignUp;

  /// Savings accounts menu
  ///
  /// In en, this message translates to:
  /// **'Savings Accounts'**
  String get savingsAccounts;

  /// Shares menu
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get shares;

  /// Transfers menu
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get transfers;

  /// Member status
  ///
  /// In en, this message translates to:
  /// **'MEMBER'**
  String get member;

  /// Quick actions section
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// Saving action
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// Loan action
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get loan;

  /// Pay action
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// View action
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// Apply action
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Bills payment
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get bills;

  /// History view
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// SACCO support title
  ///
  /// In en, this message translates to:
  /// **'SACCO Support'**
  String get saccoSupport;

  /// Support response time
  ///
  /// In en, this message translates to:
  /// **'Typically replies in a few minutes'**
  String get typicallyReplies;

  /// Chat bot greeting
  ///
  /// In en, this message translates to:
  /// **'Hello and Welcome!'**
  String get helloWelcome;

  /// Chat bot introduction
  ///
  /// In en, this message translates to:
  /// **'I\'m Selam, your Ethio SACCO digital assistant. I\'m here to help with membership, savings, loans, transfers and other SACCO services. How can I assist you today?'**
  String get supportIntro;

  /// Main menu button
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get mainMenu;

  /// Choose option text
  ///
  /// In en, this message translates to:
  /// **'Choose an option to continue:'**
  String get chooseOption;

  /// SACCO services button
  ///
  /// In en, this message translates to:
  /// **'SACCO Services'**
  String get saccoServices;

  /// Member self service button
  ///
  /// In en, this message translates to:
  /// **'Member Self Service'**
  String get memberSelfService;

  /// Exchange rate button
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeRate;

  /// Contact us button
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// FAQs button
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// Change language button
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// Biometric not available message
  ///
  /// In en, this message translates to:
  /// **'Not available on this device'**
  String get notAvailableOnDevice;

  /// Contact us subtitle
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get getInTouch;

  /// About menu
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// App version
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// Personal information menu
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// Payment preferences menu
  ///
  /// In en, this message translates to:
  /// **'Payment Preferences'**
  String get paymentPreferences;

  /// Banks and cards menu
  ///
  /// In en, this message translates to:
  /// **'Banks and Cards'**
  String get banksAndCards;

  /// Member since label
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// Account status label
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get accountStatus;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Job title
  ///
  /// In en, this message translates to:
  /// **'Senior Designer'**
  String get seniorDesigner;

  /// Choose loan type header
  ///
  /// In en, this message translates to:
  /// **'Choose Loan Type'**
  String get chooseLoanType;

  /// Select loan type subtitle
  ///
  /// In en, this message translates to:
  /// **'Select the type of loan you want to calculate'**
  String get selectLoanType;

  /// Loan history menu
  ///
  /// In en, this message translates to:
  /// **'Loan History'**
  String get loanHistory;

  /// View previous loans subtitle
  ///
  /// In en, this message translates to:
  /// **'View your previously calculated loans'**
  String get viewPreviousLoans;

  /// Calculate new loan header
  ///
  /// In en, this message translates to:
  /// **'Calculate New Loan'**
  String get calculateNewLoan;

  /// Personal loan calculator
  ///
  /// In en, this message translates to:
  /// **'Personal Loan'**
  String get personalLoanCalc;

  /// Transaction history title
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// All transactions filter
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Deposits filter
  ///
  /// In en, this message translates to:
  /// **'Deposits'**
  String get deposits;

  /// Withdrawals filter
  ///
  /// In en, this message translates to:
  /// **'Withdrawals'**
  String get withdrawals;

  /// Cash deposit transaction
  ///
  /// In en, this message translates to:
  /// **'Cash Deposit'**
  String get cashDeposit;

  /// Branch cashier source
  ///
  /// In en, this message translates to:
  /// **'Branch Cashier'**
  String get branchCashier;

  /// Completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// ATM withdrawal transaction
  ///
  /// In en, this message translates to:
  /// **'ATM Withdrawal'**
  String get atmWithdrawal;

  /// Mobile money deposit transaction
  ///
  /// In en, this message translates to:
  /// **'Mobile Money Deposit'**
  String get mobileMoneyDeposit;

  /// Wallet source
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// Transfer out transaction
  ///
  /// In en, this message translates to:
  /// **'Transfer Out'**
  String get transferOut;

  /// Security support section
  ///
  /// In en, this message translates to:
  /// **'Security & Support'**
  String get securitySupport;

  /// Savings screen title
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savingsScreen;

  /// Loans screen title
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get loansScreen;

  /// Chat bot title
  ///
  /// In en, this message translates to:
  /// **'Chat Bot'**
  String get chatBot;

  /// Chat bot greeting
  ///
  /// In en, this message translates to:
  /// **'How can I help you today?'**
  String get howCanIHelp;

  /// Chat input placeholder
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// Send button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Menu button
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Message center menu
  ///
  /// In en, this message translates to:
  /// **'Message Center'**
  String get messageCenter;

  /// Address menu
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Loan repayments tab
  ///
  /// In en, this message translates to:
  /// **'Repayments'**
  String get repayments;

  /// Loan disbursements tab
  ///
  /// In en, this message translates to:
  /// **'Disbursements'**
  String get disbursements;

  /// Share buy/sell tab
  ///
  /// In en, this message translates to:
  /// **'Buy/Sell'**
  String get buySell;

  /// Share dividends tab
  ///
  /// In en, this message translates to:
  /// **'Dividends'**
  String get dividends;

  /// Label for saving period
  ///
  /// In en, this message translates to:
  /// **'Saving days'**
  String get savingDays;

  /// Interest rate label
  ///
  /// In en, this message translates to:
  /// **'Interest Rate'**
  String get interestRate;

  /// Minimum deposit label
  ///
  /// In en, this message translates to:
  /// **'Min Deposit'**
  String get minDeposit;

  /// Maximum deposit label
  ///
  /// In en, this message translates to:
  /// **'Max Deposit'**
  String get maxDeposit;

  /// Total loan balance header
  ///
  /// In en, this message translates to:
  /// **'Total Loan Balance'**
  String get totalLoanBalance;

  /// Remaining loan amount
  ///
  /// In en, this message translates to:
  /// **'Remaining Loan'**
  String get remainingLoan;

  /// Total interest amount
  ///
  /// In en, this message translates to:
  /// **'Total Interest'**
  String get totalInterest;

  /// Initial loan amount label
  ///
  /// In en, this message translates to:
  /// **'Initial Loan Provided'**
  String get initialLoanProvided;

  /// Monthly payment amount
  ///
  /// In en, this message translates to:
  /// **'Monthly Payment'**
  String get monthlyPayment;

  /// Remaining months label
  ///
  /// In en, this message translates to:
  /// **'months left'**
  String get monthsLeft;

  /// No limit text for deposits
  ///
  /// In en, this message translates to:
  /// **'No Limit'**
  String get noLimit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en', 'om', 'so', 'ti'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'om':
      return AppLocalizationsOm();
    case 'so':
      return AppLocalizationsSo();
    case 'ti':
      return AppLocalizationsTi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
