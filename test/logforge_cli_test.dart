import 'package:logforge_cli/src/models/log_entry.dart';
import 'package:logforge_cli/src/models/log_level.dart';
import 'package:test/test.dart';

void main() {
  test('parses a well-formed log line', () {
    const line =
        '2025-12-04T15:00:32.123Z INFO [auth] user_id=42 action=login success=true';

    final entry = LogEntry.fromLine(line);

    expect(entry.level, LogLevel.info);
    expect(entry.source, 'auth');
    expect(entry.message, 'user_id=42 action=login success=true');
  });

  test('throws on invalid log line', () {
    const line = 'not a valid log line';

    expect(() => LogEntry.fromLine(line), throwsFormatException);
  });  
}