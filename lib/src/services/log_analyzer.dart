import 'dart:isolate';

import 'package:logforge_cli/src/models/log_analysis_result.dart';
import 'package:logforge_cli/src/models/log_entry.dart';
import 'package:logforge_cli/src/models/log_level.dart';

LogAnalysisResult analyzeEntries(Iterable<LogEntry> entries) {
  final countByLevel = <LogLevel, int>{};
  final countBySource = <String, int>{};
  int total = 0;

  for (final entry in entries) {
    total++;

    countByLevel.update(entry.level, (v) => (v + 1), ifAbsent: () => 1);
    countBySource.update(entry.source, (v) => (v + 1), ifAbsent: () => 1);
  }

  return LogAnalysisResult(
    totalCount: total,
    countByLevel: countByLevel,
    countBySource: countBySource,
  );
}

Future<LogAnalysisResult> analyzeEntriesInIsolate(
  List<LogEntry> entries,
) async {
  final response = await Isolate.run<Map<String, dynamic>>(
    () => analyzeEntries(entries).toMap(),
  );
  return LogAnalysisResult.fromMap(response);
}
