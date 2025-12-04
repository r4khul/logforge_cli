enum LogLevel {
  trace,
  debug,
  info,
  warn,
  error,
  fatal;

  static LogLevel fromString(String raw) {
    switch (raw.toUpperCase()) {
      case 'TRACE':
        return LogLevel.trace;
      case 'DEBUG':
        return LogLevel.debug;
      case 'INFO':
        return LogLevel.info;
      case 'WARN':
      case 'WARNING':
        return LogLevel.warn;
      case 'ERROR':
        return LogLevel.error;
      case 'FATAL':
        return LogLevel.fatal;
      default:
        throw FormatException('Unknown Log Level: $raw');
    }
  }

  @override
  String toString() {
    return name.toLowerCase();
  }
}
