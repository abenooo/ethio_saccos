// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tigrinya (`ti`).
class AppLocalizationsTi extends AppLocalizations {
  AppLocalizationsTi([String locale = 'ti']) : super(locale);

  @override
  String get appTitle => 'Ethio SACCO';

  @override
  String get welcomeBack => 'ደሓን መጻእኩም';

  @override
  String get signIn => 'እቶት';

  @override
  String signInWithBiometric(String biometricType) {
    return 'ብ$biometricType እቶት';
  }

  @override
  String get emailAddress => 'ኢመይል አድራሻ';

  @override
  String get password => 'መሕለፊ ቃል';

  @override
  String get forgotPassword => 'መሕለፊ ቃል ረሲዕካዮ?';

  @override
  String get dontHaveAccount => 'ሕሳብ የብልካን?';

  @override
  String get signUp => 'ምዝገባ';

  @override
  String get register => 'ተመዝገብ';

  @override
  String get fullName => 'ምሉእ ስም';

  @override
  String get phoneNumber => 'ቁጽሪ ተለፎን';

  @override
  String get confirmPassword => 'መሕለፊ ቃል ኣረጋግጽ';

  @override
  String get alreadyHaveAccount => 'ሕሳብ ኣለካ?';

  @override
  String get myAccounts => 'ሕሳባተይ';

  @override
  String get loanCalculator => 'ሓሳቢ ዕዳ';

  @override
  String get statements => 'መግለጺ';

  @override
  String get deposit => 'ምእታው';

  @override
  String get withdraw => 'ምውጻእ';

  @override
  String get transfer => 'ምስግጋር';

  @override
  String get settings => 'ምርጫታት';

  @override
  String get profile => 'መግለጺ ውልቀ-ሰብ';

  @override
  String get notifications => 'መግለጺታት';

  @override
  String get security => 'ድሕነት';

  @override
  String get biometricAuthentication => 'ባዮሜትሪክ ምርግጋጽ';

  @override
  String biometricEnabled(String biometricType) {
    return '$biometricType ተኸፊቱ';
  }

  @override
  String biometricDisabled(String biometricType) {
    return '$biometricType ተዓጺጉ';
  }

  @override
  String get changePassword => 'መሕለፊ ቃል ቀይር';

  @override
  String get helpCenter => 'ማእከል ሓገዝ';

  @override
  String get logout => 'ወጻኢ';

  @override
  String get balance => 'ቀሪ';

  @override
  String get mainAccount => 'ቀንዲ ሕሳብ';

  @override
  String get personalLoan => 'Personal Loan';

  @override
  String get shareAccount => 'ሕሳብ ክፍሊ';

  @override
  String get or => 'ወይ';

  @override
  String get demoCredentials => 'ናይ ምስክር መንነት';

  @override
  String get useAnyEmailPassword => 'ዝኾነ ኢመይልን መሕለፊ ቃልን ተጠቐም';

  @override
  String get example => 'ኣብነት: user@example.com / password123';

  @override
  String get vibration => 'ምንቅጥቃጥ';

  @override
  String get enabled => 'ተኸፊቱ';

  @override
  String get disabled => 'ተዓጺጉ';

  @override
  String get pushNotifications => 'ናይ ምድፋእ መግለጺታት';

  @override
  String get emailNotifications => 'ናይ ኢመይል መግለጺታት';

  @override
  String get weeklySum => 'ሳምንታዊ ጽማቕ';

  @override
  String lastChanged(String time) {
    return 'ናይ መወዳእታ ለውጢ $time';
  }

  @override
  String get twoFactorAuth => 'ክልተ-ደረጃ ምርግጋጽ';

  @override
  String get faqsAndSupport => 'ተደጋጋሚ ሕቶታትን ደገፍን';

  @override
  String get contactSupport => 'ደገፍ ርኸብ';

  @override
  String get aboutSacco => 'ብዛዕባ SACCO';

  @override
  String get privacySecurity => 'ፍትሒ ውልቀ-ሰብን ድሕነትን';

  @override
  String get fontSize => 'ዓቐን ፊደል';

  @override
  String get medium => 'Medium';

  @override
  String get theme => 'ቴማ';

  @override
  String get darkMode => 'ጸለማ ዓይነት';

  @override
  String get lightMode => 'ብርሃን ዓይነት';

  @override
  String get accountPreferences => 'ሕሳብን ምርጫታትን';

  @override
  String get support => 'ደገፍ';

  @override
  String get regularSavings => 'ልሙድ ቁጠባ';

  @override
  String get fixedDeposit => 'ቀዋሚ ምእታው 12ወርሒ';

  @override
  String get emergencyFund => 'ናይ ህጹጽ ገንዘብ';

  @override
  String get childrenEducation => 'ትምህርቲ ቆልዑ';

  @override
  String get holidaySavings => 'ቁጠባ በዓላት';

  @override
  String get viewBalancesDetails => 'ዝርዝር ቀሪ ርአ';

  @override
  String get calculatePayments => 'ክፍሊት ሓስብ';

  @override
  String get downloadView => 'ኣውርድን ርአን';

  @override
  String get addFunds => 'ገንዘብ ወስኽ';

  @override
  String get cashWithdrawal => 'ገንዘብ ምውጻእ';

  @override
  String get sendMoney => 'ገንዘብ ስደድ';

  @override
  String get viewEditProfile => 'መግለጺ ርአ/ኣርም';

  @override
  String get quickPersonalFinancing => 'ቅልጡፍ ውልቀ-ሰባዊ ገንዘብ';

  @override
  String get growYourBusiness => 'ንግድኻ ኣዕቢ';

  @override
  String get homeFinancing => 'ገንዘብ ገዛ';

  @override
  String get vehicleFinancing => 'ገንዘብ መካይን';

  @override
  String get businessLoan => 'ዕዳ ንግዲ';

  @override
  String get mortgagesLoan => 'ዕዳ ገዛ';

  @override
  String get autoLoan => 'ዕዳ መካይን';

  @override
  String get payToMerchant => 'ንነጋዳይ ክፈል';

  @override
  String get paymentRequest => 'ሕቶ ክፍሊት';

  @override
  String get ticket => 'ቲኬት';

  @override
  String get governmentServices => 'መንግስታዊ ኣገልግሎት';

  @override
  String get payFor => 'ክፈል ንዝኾነ';

  @override
  String get donations => 'ሃብታት';

  @override
  String get otherServices => 'ካልእ ኣገልግሎት';

  @override
  String get scanQr => 'QR ስካን ግበር';

  @override
  String get home => 'ገዛ';

  @override
  String get accounts => 'ሕሳባት';

  @override
  String get loans => 'ዕዳታት';

  @override
  String get more => 'ተወሳኺ';

  @override
  String get savings => 'ቁጠባ';

  @override
  String get savingsAccount => 'ሕሳብ ቁጠባ';

  @override
  String get manageSavings => 'ቁጠባ ምሕደራ';

  @override
  String get loanServices => 'ኣገልግሎታት ዕዳ';

  @override
  String get applyLoans => 'ዕዳ ሕተት';

  @override
  String get newUserSignUp => 'ሓዲሽ ተጠቃሚ ምዝገባ';

  @override
  String get savingsAccounts => 'ሕሳባት ቁጠባ';

  @override
  String get shares => 'ክፍሊታት';

  @override
  String get transfers => 'ምስግጋር';

  @override
  String get member => 'ኣባል';

  @override
  String get quickActions => 'ቅልጡፍ ተግባራት';

  @override
  String get saving => 'ቁጠባ';

  @override
  String get loan => 'ዕዳ';

  @override
  String get pay => 'ክፈል';

  @override
  String get view => 'ርአ';

  @override
  String get apply => 'ኣመልክት';

  @override
  String get bills => 'ክፍሊታት';

  @override
  String get history => 'ታሪኽ';

  @override
  String get saccoSupport => 'ደገፍ SACCO';

  @override
  String get typicallyReplies => 'ብተለምዶ ይምልስ';

  @override
  String get helloWelcome => 'ሰላምን እንቋዕ ደሓን መጻእኩምን!';

  @override
  String get supportIntro =>
      'ኣነ ሰላም እየ፣ ናይ Ethio SACCO ዲጂታላዊ ሓጋዚኹም። ኣባልነት፣ ቁጠባ፣ ዕዳ፣ ምስግጋርን ካልእ ናይ SACCO ኣገልግሎታትን ንምሕጋዝ ኣብዚ ኣለኹ። ሎሚ ከመይ ክሕግዘኩም እኽእል?';

  @override
  String get mainMenu => 'ቀንዲ ሜኑ';

  @override
  String get chooseOption => 'ምርጫ ምረጽ';

  @override
  String get saccoServices => 'ኣገልግሎታት SACCO';

  @override
  String get memberSelfService => 'ናይ ኣባል ናይ ርእሲ ኣገልግሎት';

  @override
  String get exchangeRate => 'ተመን ምልውዋጥ';

  @override
  String get contactUs => 'ርኸቡና';

  @override
  String get faqs => 'ተደጋጋሚ ሕቶታት';

  @override
  String get changeLanguage => 'ቋንቋ ቀይር';

  @override
  String get notAvailableOnDevice => 'ኣብዚ መሳርሒ ኣይርከብን';

  @override
  String get getInTouch => 'ርኸቡና';

  @override
  String get about => 'ብዛዕባ';

  @override
  String get version => 'ሕታም';

  @override
  String get personalInformation => 'ውልቀ-ሰባዊ ሓበሬታ';

  @override
  String get paymentPreferences => 'ምርጫታት ክፍሊት';

  @override
  String get banksAndCards => 'ባንክታትን ካርድታትን';

  @override
  String get memberSince => 'ኣባል ካብ';

  @override
  String get accountStatus => 'ኩነታት ሕሳብ';

  @override
  String get active => 'ንቁሕ';

  @override
  String get seniorDesigner => 'ዓቢ ዲዛይነር';

  @override
  String get chooseLoanType => 'ዓይነት ዕዳ ምረጽ';

  @override
  String get selectLoanType => 'ዓይነት ዕዳ ምምራጽ';

  @override
  String get loanHistory => 'ታሪኽ ዕዳ';

  @override
  String get viewPreviousLoans => 'ዝሓለፉ ዕዳታት ርአ';

  @override
  String get calculateNewLoan => 'ሓዲሽ ዕዳ ሓስብ';

  @override
  String get personalLoanCalc => 'ሓሳቢ ውልቀ-ሰባዊ ዕዳ';

  @override
  String get transactionHistory => 'ታሪኽ ንግዲ';

  @override
  String get all => 'ኩሉ';

  @override
  String get deposits => 'ምእታዋት';

  @override
  String get withdrawals => 'ምውጻኣት';

  @override
  String get cashDeposit => 'ገንዘብ ምእታው';

  @override
  String get branchCashier => 'ካሽየር ጨንፈር';

  @override
  String get completed => 'ተዛዚሙ';

  @override
  String get atmWithdrawal => 'ATM ምውጻእ';

  @override
  String get mobileMoneyDeposit => 'ሞባይል ገንዘብ ምእታው';

  @override
  String get wallet => 'ቦርሳ';

  @override
  String get transferOut => 'ናብ ደገ ምስግጋር';

  @override
  String get securitySupport => 'ደገፍ ድሕነት';

  @override
  String get savingsScreen => 'ገጽ ቁጠባ';

  @override
  String get loansScreen => 'ገጽ ዕዳታት';

  @override
  String get chatBot => 'ቻት ቦት';

  @override
  String get howCanIHelp => 'ከመይ ክሕግዘካ እኽእል?';

  @override
  String get typeMessage => 'መልእኽቲ ጽሓፍ...';

  @override
  String get send => 'ስደድ';

  @override
  String get back => 'ተመለስ';

  @override
  String get menu => 'ሜኑ';

  @override
  String get close => 'ዓጽግ';

  @override
  String get messageCenter => 'ማእከል መልእኽቲ';

  @override
  String get address => 'አድራሻ';

  @override
  String get repayments => 'ምምላስ ክፍሊት';

  @override
  String get disbursements => 'ምዝርጋሕ';

  @override
  String get buySell => 'ግዛእ/ሸጥ';

  @override
  String get dividends => 'ክፍሊ ትርፊ';

  @override
  String get savingDays => 'መዓልታት ቁጠባ';

  @override
  String get interestRate => 'መጠን ወለድ';

  @override
  String get minDeposit => 'ዝተሓተ ምእታው';

  @override
  String get maxDeposit => 'ዝለዓለ ምእታው';

  @override
  String get totalLoanBalance => 'ጠቕላላ ቀሪ ዕዳ';

  @override
  String get remainingLoan => 'ዝተረፈ ዕዳ';

  @override
  String get totalInterest => 'ጠቕላላ ወለድ';

  @override
  String get initialLoanProvided => 'ቀዳማይ ዝተወሃበ ዕዳ';

  @override
  String get monthlyPayment => 'ወርሓዊ ክፍሊት';

  @override
  String get monthsLeft => 'ኣዋርሕ ተሪፎም';

  @override
  String get noLimit => 'ደረት የለን';
}
