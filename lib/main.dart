import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/main_navigation_screen.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/services/auth_service.dart';
import 'splash_screen.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/localization_provider.dart';
import 'features/onboarding/services/onboarding_service.dart';
import 'features/settings/providers/biometric_provider.dart';
import 'generated/l10n/app_localizations.dart';

// Custom delegate to handle fallback for unsupported locales
class FallbackMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Support all locales, but will fallback to English for unsupported ones
    return true;
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // For unsupported locales, use English as fallback
    const fallbackLocale = Locale('en');
    
    // Check if the locale is supported by Material
    if (GlobalMaterialLocalizations.delegate.isSupported(locale)) {
      return await GlobalMaterialLocalizations.delegate.load(locale);
    } else {
      // Use English fallback for unsupported locales
      return await GlobalMaterialLocalizations.delegate.load(fallbackLocale);
    }
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

// Custom delegate to handle fallback for unsupported Cupertino locales
class FallbackCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    const fallbackLocale = Locale('en');
    
    if (GlobalCupertinoLocalizations.delegate.isSupported(locale)) {
      return await GlobalCupertinoLocalizations.delegate.load(locale);
    } else {
      return await GlobalCupertinoLocalizations.delegate.load(fallbackLocale);
    }
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BiometricProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocalizationProvider>(
      builder: (context, themeProvider, localizationProvider, _) {
        return MaterialApp(
          title: 'Ethio Saccos',
          theme: themeProvider.theme.copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          // Localization configuration
          locale: localizationProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            FallbackMaterialLocalizationsDelegate(),
            GlobalWidgetsLocalizations.delegate,
            FallbackCupertinoLocalizationsDelegate(),
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('am'), // Amharic
            Locale('om'), // Afan Oromo
            Locale('ti'), // Tigrigna
            Locale('so'), // Afan Somali
          ],
          // Locale resolution callback to handle unsupported locales
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current locale is supported
            if (locale != null) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
            }
            // If the locale is not supported, return English as fallback
            return const Locale('en');
          },
          home: const SplashScreen(),
          routes: {
            '/main': (_) => const MainNavigationScreen(),
            '/login': (_) => const LoginScreen(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    // Initialize providers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BiometricProvider>(context, listen: false).initialize();
      Provider.of<LocalizationProvider>(context, listen: false).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<bool>>(
      future: Future.wait([
        OnboardingService.isOnboardingCompleted(),
        AuthService.isLoggedIn(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading screen while checking onboarding status
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }

        // Show onboarding if not completed
        final list = snapshot.data;
        final onboardDone = (list != null && list.isNotEmpty) ? list[0] : false;
        final loggedIn = (list != null && list.length > 1) ? list[1] : false;
        if (!onboardDone) return const OnboardingScreen();
        if (!loggedIn) return const LoginScreen();
        return const MainNavigationScreen();
      },
    );
  }
}
