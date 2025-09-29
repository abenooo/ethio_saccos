import 'dart:developer' as developer;

/// Centralized logging utility following Flutter best practices
class AppLogger {
  static const String _appName = 'SACCOS';
  
  /// Log debug information (development only)
  static void debug(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log('DEBUG', message, tag: tag, error: error, stackTrace: stackTrace);
  }
  
  /// Log informational messages
  static void info(String message, {String? tag}) {
    _log('INFO', message, tag: tag);
  }
  
  /// Log warning messages
  static void warning(String message, {String? tag, Object? error}) {
    _log('WARNING', message, tag: tag, error: error);
  }
  
  /// Log error messages
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log('ERROR', message, tag: tag, error: error, stackTrace: stackTrace);
  }
  
  /// Internal logging method
  static void _log(
    String level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final logTag = tag ?? _appName;
    final logMessage = '[$level] [$logTag] $message';
    
    // Use developer.log for better debugging in Flutter
    developer.log(
      logMessage,
      name: logTag,
      error: error,
      stackTrace: stackTrace,
      level: _getLevelValue(level),
    );
  }
  
  /// Convert log level to numeric value
  static int _getLevelValue(String level) {
    switch (level) {
      case 'DEBUG':
        return 500;
      case 'INFO':
        return 800;
      case 'WARNING':
        return 900;
      case 'ERROR':
        return 1000;
      default:
        return 800;
    }
  }
}

/// Exception classes following Dart best practices
class LoanCalculationException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  
  const LoanCalculationException(
    this.message, {
    this.code,
    this.originalError,
  });
  
  @override
  String toString() => 'LoanCalculationException: $message';
}

class ValidationException implements Exception {
  final String message;
  final String field;
  
  const ValidationException(this.message, this.field);
  
  @override
  String toString() => 'ValidationException: $message (Field: $field)';
}

class StorageException implements Exception {
  final String message;
  final dynamic originalError;
  
  const StorageException(this.message, {this.originalError});
  
  @override
  String toString() => 'StorageException: $message';
}
