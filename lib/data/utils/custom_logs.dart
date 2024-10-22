import 'dart:developer';

void logError(String error) {
  log(error, name: "[Madrasati: Error]");
}

void logInfo(String info) {
  log(info, name: "[Madrasati: Info]");
}

void logWarning(String warning) {
  log(warning, name: "[Madrasati: Warning]");
}

void logDebug(String debug) {
  log(debug, name: "[Madrasati: Debug]");
}

extension LogExtension on String {
  void logError() {
    log(this, name: "[Madrasati: Error]");
  }

  void logInfo() {
    log(this, name: "[Madrasati: Info]");
  }

  void logWarning() {
    log(this, name: "[Madrasati: Warning]");
  }

  void logDebug() {
    log(this, name: "[Madrasati: Debug]");
  }
}
