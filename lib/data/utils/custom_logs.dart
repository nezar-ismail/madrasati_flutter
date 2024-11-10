import 'dart:developer';

/// Logs an error message with a specific name for the Madrasati application.
/// 
/// The [error] parameter is the error message to be logged.
/// The log entry is tagged with the name "[Madrasati: Error]" for identification.
void logError(String error) {
  log(error, name: "[Madrasati: Error]");
}


/// Logs an informational message with a specific name for the Madrasati application.
/// 
/// The [info] parameter is the informational message to be logged.
/// The log entry is tagged with the name "[Madrasati: Info]" for identification.
void logInfo(String info) {
  log(info, name: "[Madrasati: Info]");
}

/// Logs a warning message with a specific name for the Madrasati application.
/// 
/// The [warning] parameter is the warning message to be logged.
/// The log entry is tagged with the name "[Madrasati: Warning]" for identification.
void logWarning(String warning) {
  log(warning, name: "[Madrasati: Warning]");
}

/// Logs a debug message with a specific name for the Madrasati application.
/// 
/// The [debug] parameter is the debug message to be logged.
/// The log entry is tagged with the name "[Madrasati: Debug]" for identification.
void logDebug(String debug) {
  log(debug, name: "[Madrasati: Debug]");
}

extension LogExtension on String {
  /// Logs the string as an error message with a specific name for the Madrasati application.
  ///
  /// The log entry is tagged with the name "[Madrasati: Error]" for identification.
  void logError() {
    log(this, name: "[Madrasati: Error]");
  }

  /// Logs the string as an informational message with a specific name for the Madrasati application.
  ///
  /// The log entry is tagged with the name "[Madrasati: Info]" for identification.
  void logInfo() {
    log(this, name: "[Madrasati: Info]");
  }

  /// Logs the string as a warning message with a specific name for the Madrasati application.
  ///
  /// The log entry is tagged with the name "[Madrasati: Warning]" for identification.
  void logWarning() {
    log(this, name: "[Madrasati: Warning]");
  }

  /// Logs the string as a debug message with a specific name for the Madrasati application.
  ///
  /// The log entry is tagged with the name "[Madrasati: Debug]" for identification.
  void logDebug() {
    log(this, name: "[Madrasati: Debug]");
  }
}
