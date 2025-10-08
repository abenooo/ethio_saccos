import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../auth/services/biometric_service.dart';
import '../../auth/services/auth_service.dart';

class BiometricProvider extends ChangeNotifier {
  bool _isBiometricEnabled = false;
  bool _isBiometricAvailable = false;
  List<BiometricType> _availableBiometrics = [];
  String _biometricTypeName = 'Biometric Authentication';
  bool _isLoading = false;

  bool get isBiometricEnabled => _isBiometricEnabled;
  bool get isBiometricAvailable => _isBiometricAvailable;
  List<BiometricType> get availableBiometrics => _availableBiometrics;
  String get biometricTypeName => _biometricTypeName;
  bool get isLoading => _isLoading;

  /// Initialize biometric settings
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isBiometricAvailable = await BiometricService.isBiometricAvailable();
      
      if (_isBiometricAvailable) {
        _availableBiometrics = await BiometricService.getAvailableBiometrics();
        _biometricTypeName = BiometricService.getBiometricTypeName(_availableBiometrics);
        _isBiometricEnabled = await BiometricService.isBiometricEnabled();
      }
    } catch (e) {
      _isBiometricAvailable = false;
      _isBiometricEnabled = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Toggle biometric authentication
  Future<bool> toggleBiometric(String? email, String? password) async {
    if (!_isBiometricAvailable) return false;

    _isLoading = true;
    notifyListeners();

    try {
      if (!_isBiometricEnabled) {
        // Enable biometric authentication
        if (email != null && password != null) {
          // First validate credentials without logging in
          final isValidCredentials = AuthService.validateCredentials(email, password);
          
          if (!isValidCredentials) {
            _isLoading = false;
            notifyListeners();
            return false; // Invalid credentials
          }
          
          // Then setup biometric authentication
          final success = await BiometricService.setupBiometricAuth(email, password);
          if (success) {
            _isBiometricEnabled = true;
            _isLoading = false;
            notifyListeners();
            return true;
          } else {
            _isLoading = false;
            notifyListeners();
            return false; // Biometric authentication failed
          }
        } else {
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        // Disable biometric authentication
        await BiometricService.disableBiometricAuth();
        _isBiometricEnabled = false;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Perform biometric login
  Future<Map<String, String>?> performBiometricLogin() async {
    if (!_isBiometricEnabled || !_isBiometricAvailable) return null;

    try {
      return await BiometricService.performBiometricLogin();
    } catch (e) {
      return null;
    }
  }

  /// Get subtitle text for settings
  String getSubtitleText() {
    if (!_isBiometricAvailable) {
      return 'Not available on this device';
    } else if (_isBiometricEnabled) {
      return '$_biometricTypeName enabled';
    } else {
      return '$_biometricTypeName disabled';
    }
  }
}
