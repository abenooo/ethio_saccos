import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  
  Locale _locale = const Locale('en'); // Default to English
  
  Locale get locale => _locale;
  
  /// Initialize the localization provider and load saved language
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }
  
  /// Change the app language
  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;
    
    _locale = Locale(languageCode);
    
    // Save the selected language
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    
    notifyListeners();
  }
  
  /// Get the current language name for display
  String get currentLanguageName {
    switch (_locale.languageCode) {
      case 'am':
        return 'አማርኛ'; // Amharic
      case 'om':
        return 'Afaan Oromoo'; // Afan Oromo
      case 'ti':
        return 'ትግርኛ'; // Tigrigna
      case 'so':
        return 'Af-Soomaali'; // Afan Somali
      case 'en':
      default:
        return 'English';
    }
  }
  
  /// Get available languages
  List<Map<String, String>> get availableLanguages => [
    {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    {'code': 'am', 'name': 'Amharic', 'nativeName': 'አማርኛ'},
    {'code': 'om', 'name': 'Afan Oromo', 'nativeName': 'Afaan Oromoo'},
    {'code': 'ti', 'name': 'Tigrigna', 'nativeName': 'ትግርኛ'},
    {'code': 'so', 'name': 'Afan Somali', 'nativeName': 'Af-Soomaali'},
  ];
  
  /// Check if current language is RTL (Right-to-Left)
  bool get isRTL {
    // Amharic is written left-to-right, but this is here for future RTL languages
    return false;
  }
}
