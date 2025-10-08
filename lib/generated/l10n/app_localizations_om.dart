// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oromo (`om`).
class AppLocalizationsOm extends AppLocalizations {
  AppLocalizationsOm([String locale = 'om']) : super(locale);

  @override
  String get appTitle => 'Ethio SACCO';

  @override
  String get welcomeBack => 'Baga nagaan deebitan';

  @override
  String get signIn => 'Seeni';

  @override
  String signInWithBiometric(String biometricType) {
    return 'Mallattoo ${biometricType}n seeni';
  }

  @override
  String get emailAddress => 'Teessoo email';

  @override
  String get password => 'Jecha icciitii';

  @override
  String get forgotPassword => 'Jecha icciitii irraanfatte?';

  @override
  String get dontHaveAccount => 'Herrega hin qabdu?';

  @override
  String get signUp => 'Galmaa\'uu';

  @override
  String get register => 'Galmeessuu';

  @override
  String get fullName => 'Maqaa guutuu';

  @override
  String get phoneNumber => 'Lakkoofsa bilbilaa';

  @override
  String get confirmPassword => 'Jecha icciitii mirkaneessuu';

  @override
  String get alreadyHaveAccount => 'Duraan herrega qabda?';

  @override
  String get myAccounts => 'Herregni koo';

  @override
  String get loanCalculator => 'Shallagaa liqii';

  @override
  String get statements => 'Gabaasa';

  @override
  String get deposit => 'Kuusaa';

  @override
  String get withdraw => 'Baasuu';

  @override
  String get transfer => 'Dabarsuu';

  @override
  String get settings => 'Qindaa\'ina';

  @override
  String get profile => 'Seenaa dhuunfaa';

  @override
  String get notifications => 'Beeksisa';

  @override
  String get security => 'Nageenya';

  @override
  String get biometricAuthentication => 'Ragaa mallattoo';

  @override
  String biometricEnabled(String biometricType) {
    return '$biometricType dandeessifame';
  }

  @override
  String biometricDisabled(String biometricType) {
    return '$biometricType cufame';
  }

  @override
  String get changePassword => 'Jecha icciitii jijjiirii';

  @override
  String get helpCenter => 'Giddugala gargaarsaa';

  @override
  String get logout => 'Ba\'uu';

  @override
  String get balance => 'Hafe';

  @override
  String get mainAccount => 'Herreg guddaa';

  @override
  String get personalLoan => 'Personal Loan';

  @override
  String get shareAccount => 'Herreg qooda';

  @override
  String get or => 'YKNI';

  @override
  String get demoCredentials => 'Ragaa agarsiisaa';

  @override
  String get useAnyEmailPassword =>
      'Email fi jecha icciitii kamiyyuu fayyadamuu';

  @override
  String get example => 'Fakkenya: user@example.com / password123';

  @override
  String get vibration => 'Sochoosuu';

  @override
  String get enabled => 'Dandeessifame';

  @override
  String get disabled => 'Cufame';

  @override
  String get pushNotifications => 'Beeksisa dhiibuu';

  @override
  String get emailNotifications => 'Beeksisa email';

  @override
  String get weeklySum => 'Cuunfaa torbanii';

  @override
  String lastChanged(String time) {
    return 'Yeroo dhumaa jijjiirame $time';
  }

  @override
  String get twoFactorAuth => 'Ragaa sadarkaa lama';

  @override
  String get faqsAndSupport => 'Gaaffii fi deebii fi gargaarsa';

  @override
  String get contactSupport => 'Gargaarsa quunnamuu';

  @override
  String get aboutSacco => 'Waa\'ee SACCO';

  @override
  String get privacySecurity => 'Dhuunfaa fi Nageenya';

  @override
  String get fontSize => 'Guddina qubee';

  @override
  String get medium => 'Medium';

  @override
  String get theme => 'Bifa';

  @override
  String get darkMode => 'Haala dukkana';

  @override
  String get lightMode => 'Haala ifa';

  @override
  String get accountPreferences => 'Herreg fi Filannoo';

  @override
  String get support => 'Gargaarsa';

  @override
  String get regularSavings => 'Qusannaa idilee';

  @override
  String get fixedDeposit => 'Kuusaa dhaabbataa 12J';

  @override
  String get emergencyFund => 'Maallaga hatattamaa';

  @override
  String get childrenEducation => 'Barnoota ijoollee';

  @override
  String get holidaySavings => 'Qusannaa ayyaanaa';

  @override
  String get viewBalancesDetails => 'Bal\'ina haraagaa ilaali';

  @override
  String get calculatePayments => 'Kaffaltii shallaguu';

  @override
  String get downloadView => 'Buufachuu fi ilaaluu';

  @override
  String get addFunds => 'Maallaga dabaluu';

  @override
  String get cashWithdrawal => 'Qarshii baasuu';

  @override
  String get sendMoney => 'Qarshii erguu';

  @override
  String get viewEditProfile => 'Seenaa dhuunfaa ilaali/gulaaluu';

  @override
  String get quickPersonalFinancing => 'Maallaqsiisa dhuunfaa saffisaa';

  @override
  String get growYourBusiness => 'Daldala kee guddisuu';

  @override
  String get homeFinancing => 'Maallaqsiisa manaa';

  @override
  String get vehicleFinancing => 'Maallaqsiisa konkolaataa';

  @override
  String get businessLoan => 'Liqii daldalaa';

  @override
  String get mortgagesLoan => 'Liqii manaa';

  @override
  String get autoLoan => 'Liqii konkolaataa';

  @override
  String get payToMerchant => 'Daldalaatti kaffaltii';

  @override
  String get paymentRequest => 'Gaafata kaffaltii';

  @override
  String get ticket => 'Tiikeetii';

  @override
  String get governmentServices => 'Tajaajila mootummaa';

  @override
  String get payFor => 'Kaffaltii';

  @override
  String get donations => 'Kennaa';

  @override
  String get otherServices => 'Tajaajila biroo';

  @override
  String get scanQr => 'QR skaanii gochuu';

  @override
  String get home => 'Mana';

  @override
  String get accounts => 'Herregootaa';

  @override
  String get loans => 'Liqii';

  @override
  String get more => 'Dabalataa';

  @override
  String get savings => 'Qusannaa';

  @override
  String get savingsAccount => 'Herreg qusannaa';

  @override
  String get manageSavings => 'Qusannaa bulchuu';

  @override
  String get loanServices => 'Tajaajila liqii';

  @override
  String get applyLoans => 'Liqii gaafachuu';

  @override
  String get newUserSignUp => 'Fayyadamaa haaraa galmeessuu';

  @override
  String get savingsAccounts => 'Herregootaa qusannaa';

  @override
  String get shares => 'Qooda';

  @override
  String get transfers => 'Dabarsuu';

  @override
  String get member => 'Miseensa';

  @override
  String get quickActions => 'Gocha saffisaa';

  @override
  String get saving => 'Qusannaa';

  @override
  String get loan => 'Liqii';

  @override
  String get pay => 'Kaffali';

  @override
  String get view => 'Ilaali';

  @override
  String get apply => 'Iyyaduu';

  @override
  String get bills => 'Kaffaltii';

  @override
  String get history => 'Seenaa';

  @override
  String get saccoSupport => 'Gargaarsa SACCO';

  @override
  String get typicallyReplies => 'Yeroo baay\'ee deebii kenna';

  @override
  String get helloWelcome => 'Nagaan fi baga nagaan dhuftan!';

  @override
  String get supportIntro =>
      'Ani Selam, gargaartuu dijitaalaa Ethio SACCO keessan. Miseensummaa, qusannaa, liqii, dabarsuu fi tajaajila SACCO biroo irratti gargaaruuf as jira. Har\'a akkamiin isin gargaaruu danda\'a?';

  @override
  String get mainMenu => 'Menyuu guddaa';

  @override
  String get chooseOption => 'Filannoo filadhu';

  @override
  String get saccoServices => 'Tajaajila SACCO';

  @override
  String get memberSelfService => 'Tajaajila ofii miseensaa';

  @override
  String get exchangeRate => 'Gatii jijjiirraa';

  @override
  String get contactUs => 'Nu quunnamaa';

  @override
  String get faqs => 'Gaaffii fi deebii';

  @override
  String get changeLanguage => 'Afaan jijjiirii';

  @override
  String get notAvailableOnDevice => 'Meeshaa kana irratti hin jiru';

  @override
  String get getInTouch => 'Nu quunnamaa';

  @override
  String get about => 'Waa\'ee';

  @override
  String get version => 'Fooyya\'aa';

  @override
  String get personalInformation => 'Odeeffannoo dhuunfaa';

  @override
  String get paymentPreferences => 'Filannoo kaffaltii';

  @override
  String get banksAndCards => 'Baankii fi kaardii';

  @override
  String get memberSince => 'Miseensa tahe';

  @override
  String get accountStatus => 'Haala herregaa';

  @override
  String get active => 'Ka\'aa';

  @override
  String get seniorDesigner => 'Dizaayinara olaanaa';

  @override
  String get chooseLoanType => 'Gosa liqii filadhu';

  @override
  String get selectLoanType => 'Gosa liqii filachuu';

  @override
  String get loanHistory => 'Seenaa liqii';

  @override
  String get viewPreviousLoans => 'Liqii duraa ilaali';

  @override
  String get calculateNewLoan => 'Liqii haaraa shallaguu';

  @override
  String get personalLoanCalc => 'Shallagaa liqii dhuunfaa';

  @override
  String get transactionHistory => 'Seenaa daldalaa';

  @override
  String get all => 'Hundaa';

  @override
  String get deposits => 'Kuusaa';

  @override
  String get withdrawals => 'Baasuu';

  @override
  String get cashDeposit => 'Qarshii kuusuu';

  @override
  String get branchCashier => 'Kaashiyera damee';

  @override
  String get completed => 'Xumurame';

  @override
  String get atmWithdrawal => 'ATM baasuu';

  @override
  String get mobileMoneyDeposit => 'Qarshii mobaayilii kuusuu';

  @override
  String get wallet => 'Korojoo';

  @override
  String get transferOut => 'Gara alaatti dabarsuu';

  @override
  String get securitySupport => 'Gargaarsa nageenya';

  @override
  String get savingsScreen => 'Fuula qusannaa';

  @override
  String get loansScreen => 'Fuula liqii';

  @override
  String get chatBot => 'Chaatii boottii';

  @override
  String get howCanIHelp => 'Akkamiin sin gargaaruu danda\'a?';

  @override
  String get typeMessage => 'Ergaa barreessi...';

  @override
  String get send => 'Erguu';

  @override
  String get back => 'Duubatti';

  @override
  String get menu => 'Menyuu';

  @override
  String get close => 'Cufuu';

  @override
  String get messageCenter => 'Giddugala ergaa';

  @override
  String get address => 'Teessoo';

  @override
  String get repayments => 'Deebii kaffaltii';

  @override
  String get disbursements => 'Raabsuu';

  @override
  String get buySell => 'Bituu/Gurguruu';

  @override
  String get dividends => 'Bu\'aa qoodamuu';

  @override
  String get savingDays => 'Guyyoota qusannaa';

  @override
  String get interestRate => 'Dhalaa dhala';

  @override
  String get minDeposit => 'Kuusaa xiqqaa';

  @override
  String get maxDeposit => 'Kuusaa guddaa';

  @override
  String get totalLoanBalance => 'Walii galii liqii hafe';

  @override
  String get remainingLoan => 'Liqii hafe';

  @override
  String get totalInterest => 'Walii galii dhala';

  @override
  String get initialLoanProvided => 'Liqii jalqabaa kenname';

  @override
  String get monthlyPayment => 'Kaffaltii ji\'aa';

  @override
  String get monthsLeft => 'ji\'oota hafan';

  @override
  String get noLimit => 'Daangaa hin qabu';
}
