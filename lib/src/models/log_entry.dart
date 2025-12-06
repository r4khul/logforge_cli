import 'package:logforge/src/models/log_level.dart';

class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String source;
  final String message;

  const LogEntry({
    required this.timestamp,
    required this.level,
    required this.source,
    required this.message,
  });

  factory LogEntry.fromLine(String line) {
    final pattern = RegExp(r'^(\S+)\s+(\S+)\s+\[(.+?)\]\s+(.*)$');
    final match = pattern.firstMatch(line);

    if (match == null) {
      throw FormatException('Line does not match the log format: $line');
    }

    final timestamp = DateTime.parse(match.group(1)!);
    final level = LogLevel.fromString(match.group(2)!);
    final source = match.group(3)!;
    final message = match.group(4)!;

    return LogEntry(
      timestamp: timestamp,
      level: level,
      source: source,
      message: message,
    );
  }

  LogEntry copyWith({
    DateTime? timestamp,
    LogLevel? level,
    String? source,
    String? message,
  }) {
    return LogEntry(
      timestamp: timestamp ?? this.timestamp,
      level: level ?? this.level,
      source: source ?? this.source,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '${timestamp.toIso8601String()} ${level.toString()} [$source] $message';
  }
}
