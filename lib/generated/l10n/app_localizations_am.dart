// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'ሳኮስ ኢትዮጵያ';

  @override
  String get welcomeBack => 'እንኳን ደህና መጡ,';

  @override
  String get signIn => 'ግባ';

  @override
  String signInWithBiometric(String biometricType) {
    return 'በ$biometricType ግባ';
  }

  @override
  String get emailAddress => 'ኢሜይል አድራሻ';

  @override
  String get password => 'የይለፍ ቃል';

  @override
  String get forgotPassword => 'የይለፍ ቃልዎን ረሱት?';

  @override
  String get dontHaveAccount => 'መለያ የሎትም?';

  @override
  String get signUp => 'ይመዝገቡ';

  @override
  String get register => 'ተመዝገብ';

  @override
  String get fullName => 'ሙሉ ስም';

  @override
  String get phoneNumber => 'ስልክ ቁጥር';

  @override
  String get confirmPassword => 'የይለፍ ቃል አረጋግጥ';

  @override
  String get alreadyHaveAccount => 'ቀደም ሲል መለያ አለዎት?';

  @override
  String get myAccounts => 'የእኔ መለያዎች';

  @override
  String get loanCalculator => 'የብድር ካልኩሌተር';

  @override
  String get statements => 'መግለጫዎች';

  @override
  String get deposit => 'ማስቀመጥ';

  @override
  String get withdraw => 'ማውጣት';

  @override
  String get transfer => 'ማስተላለፍ';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String get profile => 'መገለጫ';

  @override
  String get notifications => 'ማሳወቂያዎች';

  @override
  String get security => 'ደህንነት እና ድጋፍ';

  @override
  String get biometricAuthentication => 'ባዮሜትሪክ ማረጋገጫ';

  @override
  String biometricEnabled(String biometricType) {
    return '$biometricType ነቅቷል';
  }

  @override
  String biometricDisabled(String biometricType) {
    return '$biometricType ጠፍቷል';
  }

  @override
  String get changePassword => 'የይለፍ ቃል ቀይር';

  @override
  String get helpCenter => 'የእርዳታ ማዕከል';

  @override
  String get logout => 'ውጣ';

  @override
  String get balance => 'ሂሳብ';

  @override
  String get mainAccount => 'ዋና መለያ';

  @override
  String get personalLoan => 'የግል ብድር';

  @override
  String get shareAccount => 'የአክሲዮን መለያ';

  @override
  String get or => 'ወይም';

  @override
  String get demoCredentials => 'የሙከራ ማረጋገጫዎች';

  @override
  String get useAnyEmailPassword => 'ለመግባት ማንኛውም ኢሜይል እና የይለፍ ቃል ይጠቀሙ';

  @override
  String get example => 'ምሳሌ: user@example.com / password123';

  @override
  String get vibration => 'ንዝረት';

  @override
  String get enabled => 'ነቅቷል';

  @override
  String get disabled => 'ተሰናክሏል';

  @override
  String get pushNotifications => 'የመላክ ማሳወቂያዎች';

  @override
  String get emailNotifications => 'የኢሜይል ማሳወቂያዎች';

  @override
  String get weeklySum => 'ሳምንታዊ ማጠቃለያ';

  @override
  String lastChanged(String time) {
    return 'መጨረሻ የተቀየረው $time';
  }

  @override
  String get twoFactorAuth => 'ባለሁለት ደረጃ ማረጋገጫ';

  @override
  String get faqsAndSupport => 'ተደጋጋሚ ጥያቄዎች እና ድጋፍ';

  @override
  String get contactSupport => 'ድጋፍ ያግኙ';

  @override
  String get aboutSacco => 'ስለ ሳኮ';

  @override
  String get privacySecurity => 'ግላዊነት እና ደህንነት';

  @override
  String get fontSize => 'የፊደል መጠን';

  @override
  String get medium => 'መካከለኛ';

  @override
  String get theme => 'ገጽታ';

  @override
  String get darkMode => 'ጨለማ ገጽታ';

  @override
  String get lightMode => 'ብሩህ ገጽታ';

  @override
  String get accountPreferences => 'መለያ እና ምርጫዎች';

  @override
  String get support => 'ድጋፍ';

  @override
  String get regularSavings => 'መደበኛ ቁጠባ';

  @override
  String get fixedDeposit => 'የተወሰነ ጊዜ ተቀማጭ';

  @override
  String get emergencyFund => 'የአደጋ ጊዜ ገንዘብ';

  @override
  String get childrenEducation => 'የልጆች ትምህርት';

  @override
  String get holidaySavings => 'የበዓል ቁጠባ';

  @override
  String get viewBalancesDetails => 'ሂሳቦችን እና ዝርዝሮችን ይመልከቱ';

  @override
  String get calculatePayments => 'ክፍያዎችን ያስሉ';

  @override
  String get downloadView => 'አውርድ እና ይመልከቱ';

  @override
  String get addFunds => 'ገንዘብ ያክሉ';

  @override
  String get cashWithdrawal => 'ገንዘብ ማውጣት';

  @override
  String get sendMoney => 'ገንዘብ ላክ';

  @override
  String get viewEditProfile => 'መገለጫ ይመልከቱ እና ያርትዑ';

  @override
  String get quickPersonalFinancing => 'ፈጣን የግል ፋይናንስ';

  @override
  String get growYourBusiness => 'ንግድዎን ያሳድጉ';

  @override
  String get homeFinancing => 'የቤት ፋይናንስ';

  @override
  String get vehicleFinancing => 'የተሽከርካሪ ፋይናንስ';

  @override
  String get businessLoan => 'የንግድ ብድር';

  @override
  String get mortgagesLoan => 'የቤት ብድር';

  @override
  String get autoLoan => 'የመኪና ብድር';

  @override
  String get payToMerchant => 'ለነጋዴ ክፈል';

  @override
  String get paymentRequest => 'የክፍያ ጥያቄ';

  @override
  String get ticket => 'ቲኬት';

  @override
  String get governmentServices => 'የመንግስት አገልግሎቶች';

  @override
  String get payFor => 'ክፈል ለ';

  @override
  String get donations => 'ልገሳዎች';

  @override
  String get otherServices => 'ሌሎች አገልግሎቶች';

  @override
  String get scanQr => 'QR ስካን';

  @override
  String get home => 'ቤት';

  @override
  String get accounts => 'መለያዎች';

  @override
  String get loans => 'ብድሮች';

  @override
  String get more => 'ተጨማሪ';

  @override
  String get savings => 'ቁጠባ';

  @override
  String get savingsAccount => 'የቁጠባ መለያ';

  @override
  String get manageSavings => 'ቁጠባዎን ያስተዳድሩ፣ ወለድ እና ተቀማጭ ገንዘብ ይመልከቱ';

  @override
  String get loanServices => 'የብድር አገልግሎቶች';

  @override
  String get applyLoans => 'ለብድር ያመልክቱ፣ የብድር ሁኔታ እና ክፍያዎችን ይመልከቱ';

  @override
  String get newUserSignUp => 'አዲስ ተጠቃሚ ነኝ። ይመዝገቡ';

  @override
  String get savingsAccounts => 'የቁጠባ መለያዎች';

  @override
  String get shares => 'አክሲዮኖች';

  @override
  String get transfers => 'ማስተላለፊያዎች';

  @override
  String get member => 'አባል';

  @override
  String get quickActions => 'ፈጣን እርምጃዎች';

  @override
  String get saving => 'ቁጠባ';

  @override
  String get loan => 'ብድር';

  @override
  String get pay => 'ክፈል';

  @override
  String get view => 'ይመልከቱ';

  @override
  String get apply => 'ያመልክቱ';

  @override
  String get bills => 'ሂሳቦች';

  @override
  String get history => 'ታሪክ';

  @override
  String get saccoSupport => 'የሳኮ ድጋፍ';

  @override
  String get typicallyReplies => 'በአብዛኛው በጥቂት ደቂቃዎች ውስጥ ይመልሳል';

  @override
  String get helloWelcome => 'ሰላም እና እንኳን ደህና መጡ!';

  @override
  String get supportIntro =>
      'እኔ ሰላም ነኝ፣ የእርስዎ የኢትዮ ሳኮ ዲጂታል ረዳት። በአባልነት፣ ቁጠባ፣ ብድር፣ ማስተላለፊያ እና ሌሎች የሳኮ አገልግሎቶች ላይ ለመርዳት እዚህ ነኝ። ዛሬ እንዴት ልረዳዎት?';

  @override
  String get mainMenu => 'ዋና ሜኑ';

  @override
  String get chooseOption => 'ለመቀጠል አንድ አማራጭ ይምረጡ:';

  @override
  String get saccoServices => 'የሳኮ አገልግሎቶች';

  @override
  String get memberSelfService => 'የአባል ራስ አገልግሎት';

  @override
  String get exchangeRate => 'የምንዛሪ ተመን';

  @override
  String get contactUs => 'ያግኙን';

  @override
  String get faqs => 'ተደጋጋሚ ጥያቄዎች';

  @override
  String get changeLanguage => 'ቋንቋ ይቀይሩ';

  @override
  String get notAvailableOnDevice => 'በዚህ መሳሪያ ላይ አይገኝም';

  @override
  String get getInTouch => 'ያግኙን';

  @override
  String get about => 'ስለ';

  @override
  String get version => 'ስሪት 1.0.0';

  @override
  String get personalInformation => 'የግል መረጃ';

  @override
  String get paymentPreferences => 'የክፍያ ምርጫዎች';

  @override
  String get banksAndCards => 'ባንኮች እና ካርዶች';

  @override
  String get memberSince => 'አባል ከ';

  @override
  String get accountStatus => 'የመለያ ሁኔታ';

  @override
  String get active => 'ንቁ';

  @override
  String get seniorDesigner => 'ሲኒየር ዲዛይነር';

  @override
  String get chooseLoanType => 'የብድር አይነት ይምረጡ';

  @override
  String get selectLoanType => 'ማስላት የሚፈልጉትን የብድር አይነት ይምረጡ';

  @override
  String get loanHistory => 'የብድር ታሪክ';

  @override
  String get viewPreviousLoans => 'ቀደም ሲል የተሰሉ ብድሮችዎን ይመልከቱ';

  @override
  String get calculateNewLoan => 'አዲስ ብድር ያስሉ';

  @override
  String get personalLoanCalc => 'የግል ብድር';

  @override
  String get transactionHistory => 'የግብይት ታሪክ';

  @override
  String get all => 'ሁሉም';

  @override
  String get deposits => 'ተቀማጭ ገንዘቦች';

  @override
  String get withdrawals => 'መውጫዎች';

  @override
  String get cashDeposit => 'የገንዘብ ተቀማጭ';

  @override
  String get branchCashier => 'የቅርንጫፍ ገንዘብ ያዥ';

  @override
  String get completed => 'ተጠናቅቋል';

  @override
  String get atmWithdrawal => 'ኤቲኤም መውጫ';

  @override
  String get mobileMoneyDeposit => 'የሞባይል ገንዘብ ተቀማጭ';

  @override
  String get wallet => 'ዋሌት';

  @override
  String get transferOut => 'ማስተላለፊያ ወጪ';

  @override
  String get securitySupport => 'ደህንነት እና ድጋፍ';

  @override
  String get savingsScreen => 'ቁጠባ';

  @override
  String get loansScreen => 'ብድሮች';

  @override
  String get chatBot => 'የውይይት ሮቦት';

  @override
  String get howCanIHelp => 'ዛሬ እንዴት ልረዳዎት?';

  @override
  String get typeMessage => 'መልእክት ይተይቡ...';

  @override
  String get send => 'ላክ';

  @override
  String get back => 'ተመለስ';

  @override
  String get menu => 'ሜኑ';

  @override
  String get close => 'ዝጋ';

  @override
  String get messageCenter => 'የመልእክት ማዕከል';

  @override
  String get address => 'አድራሻ';

  @override
  String get repayments => 'ክፍያዎች';

  @override
  String get disbursements => 'ብድር ማከፋፈያ';

  @override
  String get buySell => 'ግዢ/ሽያጭ';

  @override
  String get dividends => 'ትርፍ ክፍፍል';

  @override
  String get savingDays => 'የቁጠባ ቀናት';

  @override
  String get interestRate => 'የወለድ መጠን';

  @override
  String get minDeposit => 'ዝቅተኛ ተቀማጭ';

  @override
  String get maxDeposit => 'ከፍተኛ ተቀማጭ';

  @override
  String get totalLoanBalance => 'አጠቃላይ የብድር ቀሪ';

  @override
  String get remainingLoan => 'የቀረ ብድር';

  @override
  String get totalInterest => 'አጠቃላይ ወለድ';

  @override
  String get initialLoanProvided => 'መጀመሪያ የተሰጠ ብድር';

  @override
  String get monthlyPayment => 'ወርሃዊ ክፍያ';

  @override
  String get monthsLeft => 'ወራት ቀርተዋል';

  @override
  String get noLimit => 'ገደብ የለም';
}
