import 'package:flutter/material.dart';
import '../../generated/l10n/app_localizations.dart';

extension LocalizationExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  
  /// Get localized biometric type name
  String getBiometricTypeName(String biometricType) {
    switch (biometricType.toLowerCase()) {
      case 'fingerprint':
        return 'Fingerprint'; // Can be localized later
      case 'face':
      case 'faceid':
        return 'Face ID'; // Can be localized later
      case 'touchid':
        return 'Touch ID'; // Can be localized later
      default:
        return biometricType;
    }
  }
}
