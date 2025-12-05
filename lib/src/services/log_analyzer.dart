import 'package:logforge_cli/src/models/log_entry.dart';
import 'package:logforge_cli/src/models/log_level.dart';

class LogAnalysisResult {
  final int totalCount;
  final Map<LogLevel, int> countByLevel;
  final Map<String, int> countBySource;

  LogAnalysisResult({
    required this.totalCount,
    required this.countByLevel,
    required this.countBySource,
  });
}

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
