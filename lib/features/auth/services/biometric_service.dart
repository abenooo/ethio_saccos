import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricService {
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _biometricCredentialsKey = 'biometric_credentials';
  
  static final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if biometric authentication is available on the device
  static Future<bool> isBiometricAvailable() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  /// Get available biometric types
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  /// Check if biometric authentication is enabled in settings
  static Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  /// Enable or disable biometric authentication
  static Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  /// Store user credentials for biometric authentication
  static Future<void> storeBiometricCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_biometricCredentialsKey, '$email:$password');
  }

  /// Get stored biometric credentials
  static Future<Map<String, String>?> getBiometricCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final credentials = prefs.getString(_biometricCredentialsKey);
    
    if (credentials != null && credentials.contains(':')) {
      final parts = credentials.split(':');
      if (parts.length == 2) {
        return {
          'email': parts[0],
          'password': parts[1],
        };
      }
    }
    return null;
  }

  /// Clear stored biometric credentials
  static Future<void> clearBiometricCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biometricCredentialsKey);
  }

  /// Authenticate using biometrics
  static Future<bool> authenticateWithBiometrics({
    String localizedReason = 'Please authenticate to access your account',
  }) async {
    try {
      print('BiometricService: Checking device capabilities...');
      
      // Check if device supports biometrics
      final isAvailable = await _localAuth.canCheckBiometrics;
      print('BiometricService: Can check biometrics: $isAvailable');
      
      if (!isAvailable) {
        print('BiometricService: Device does not support biometrics');
        return false;
      }
      
      // Get available biometrics
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      print('BiometricService: Available biometrics: $availableBiometrics');
      
      if (availableBiometrics.isEmpty) {
        print('BiometricService: No biometrics enrolled on device');
        return false;
      }
      
      print('BiometricService: Starting authentication with reason: $localizedReason');
      
      final bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          biometricOnly: false, // Allow fallback to device credentials if needed
          stickyAuth: true,
        ),
      );
      
      print('BiometricService: Authentication completed: $isAuthenticated');
      return isAuthenticated;
    } catch (e) {
      print('BiometricService: Authentication error: $e');
      return false;
    }
  }

  /// Get biometric type name for display
  static String getBiometricTypeName(List<BiometricType> biometrics) {
    if (biometrics.contains(BiometricType.face)) {
      return 'Face ID';
    } else if (biometrics.contains(BiometricType.fingerprint)) {
      return 'Fingerprint';
    } else if (biometrics.contains(BiometricType.iris)) {
      return 'Iris';
    } else if (biometrics.contains(BiometricType.strong) || 
               biometrics.contains(BiometricType.weak)) {
      return 'Biometric';
    }
    return 'Biometric Authentication';
  }

  /// Setup biometric authentication (enable and store credentials)
  /// Note: Credential validation should be done before calling this method
  static Future<bool> setupBiometricAuth(String email, String password) async {
    try {
      // Check if biometric is available first
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        print('Biometric not available on device');
        return false;
      }

      // Check available biometric types
      final biometrics = await getAvailableBiometrics();
      if (biometrics.isEmpty) {
        print('No biometric types available');
        return false;
      }

      print('Available biometrics: $biometrics');

      // For setup, we'll skip the biometric authentication step and just store credentials
      // The user will authenticate when they actually try to login with biometrics
      await storeBiometricCredentials(email, password);
      await setBiometricEnabled(true);
      print('Biometric setup successful - credentials stored');
      return true;
    } catch (e) {
      print('Biometric setup error: $e');
      return false;
    }
  }

  /// Disable biometric authentication
  static Future<void> disableBiometricAuth() async {
    await setBiometricEnabled(false);
    await clearBiometricCredentials();
  }

  /// Perform biometric login
  static Future<Map<String, String>?> performBiometricLogin() async {
    try {
      print('BiometricService: Checking if biometric is enabled...');
      final isEnabled = await isBiometricEnabled();
      print('BiometricService: Biometric enabled: $isEnabled');
      
      if (!isEnabled) {
        print('BiometricService: Biometric not enabled, returning null');
        return null;
      }

      print('BiometricService: Starting biometric authentication...');
      final authenticated = await authenticateWithBiometrics(
        localizedReason: 'Authenticate to sign in to your account',
      );
      print('BiometricService: Authentication result: $authenticated');

      if (authenticated) {
        print('BiometricService: Getting stored credentials...');
        final credentials = await getBiometricCredentials();
        print('BiometricService: Retrieved credentials: ${credentials != null ? "found" : "not found"}');
        return credentials;
      }
      print('BiometricService: Authentication failed, returning null');
      return null;
    } catch (e) {
      print('BiometricService: Error during biometric login: $e');
      return null;
    }
  }
}
