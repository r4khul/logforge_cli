import 'dart:async';

import 'package:logforge_cli/src/models/log_entry.dart';

class LogEntryTransformer extends StreamTransformerBase<String, LogEntry> {
  const LogEntryTransformer();

  @override
  Stream<LogEntry> bind(Stream<String> stream) async* {
    await for (final line in stream) {
      if (line.trim().isEmpty) {
        continue;
      }

      try {
        final entry = LogEntry.fromLine(line);
        yield entry;
      } on FormatException {
        continue;
      }
    }
  }
}
