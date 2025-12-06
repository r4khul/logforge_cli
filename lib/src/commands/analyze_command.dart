import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logforge_cli/src/models/log_analysis_result.dart';
import 'package:logforge_cli/src/models/log_entry.dart';
import 'package:logforge_cli/src/models/log_filter_criteria.dart';
import 'package:logforge_cli/src/models/log_level.dart';
import 'package:logforge_cli/src/services/file_reader.dart';
import 'package:logforge_cli/src/services/log_analyzer.dart';
import 'package:logforge_cli/src/services/log_filter.dart';
import 'package:logforge_cli/src/transformers/log_entry_transformer.dart';

class AnalyzeCommand extends Command<void> {
  @override
  final String name = 'analyze';
  @override
  final String description =
      'Analyze log files with optional filters and prints basic metrics.';

  AnalyzeCommand() {
    argParser
      ..addOption(
        'file',
        abbr: 'f',
        help: 'Path to the file to analyze.',
        valueHelp: 'path',
      )
      ..addOption(
        'level',
        help: 'Filter by log level (e.x. INFO, ERROR).',
        valueHelp: 'LEVEL',
      )
      ..addOption(
        'source',
        help: 'Filter by log source (e.x. auth, db).',
        valueHelp: 'SOURCE',
      )
      ..addOption(
        'from',
        help: 'Filter entries from this ISO-8601 timestamp (inclusive).',
        valueHelp: 'ISO_TIMESTAMP',
      )
      ..addOption(
        'to',
        help: 'Filter entries up to this ISO-8601 timestamp (inclusive).',
        valueHelp: 'ISO_TIMESTAMP',
      )
      ..addOption(
        'message',
        help: 'Filter entries which matches the entered message.',
        valueHelp: 'MESSAGE',
      );
  }

  @override
  Future<void> run() async {
    final String? filePath = argResults!['file'] as String?;

    if (filePath == null || filePath.trim().isEmpty) {
      throw UsageException('Missing required option --file', usage);
    }

    final levelStr = argResults!['level'] as String?;
    final source = argResults!['source'] as String?;
    final fromStr = argResults!['from'] as String?;
    final toStr = argResults!['to'] as String?;
    final message = argResults!['message'] as String?;

    LogLevel? level;
    DateTime? from;
    DateTime? to;

    try {
      if (levelStr != null) {
        level = LogLevel.fromString(levelStr);
      }
      if (fromStr != null) {
        from = DateTime.parse(fromStr);
      }
      if (toStr != null) {
        to = DateTime.parse(toStr);
      }
    } on FormatException catch (e) {
      throw UsageException('Invalid filter value: ${e.message}', usage);
    }

    final criteria = LogFilterCriteria(
      level: level,
      source: source,
      startDate: from,
      endDate: to,
      messageContains: message,
    );

    final filteredEntries = <LogEntry>[];

    try {
      final lines = readFileStream(filePath);
      final entriesStream = lines.transform(const LogEntryTransformer());

      await for (final entry in entriesStream) {
        if (!matchesCriteria(entry, criteria)) continue;
        filteredEntries.add(entry);
      }
    } on FileSystemException catch (e) {
      stderr.writeln("Error reading the file: ${e.message}");
      stderr.writeln("Path: ${e.path}");
    }

    // final result = analyzeEntries(filteredEntries); currently using isolates
    final result = await analyzeEntriesInIsolate(filteredEntries);
    _printAnalysis(result, criteria);
  }

  void _printAnalysis(LogAnalysisResult result, LogFilterCriteria criteria) {
    stdout.writeln();
    stdout.writeln('-------------------------');
    stdout.writeln('LogForge Analysis Result');
    stdout.writeln('-------------------------');
    stdout.writeln();

    if (criteria.hasAnyFilter) {
      stdout.writeln('Filters:');
      if (criteria.level != null) {
        stdout.writeln('Level: ${criteria.level.toString()}');
      }
      if (criteria.source != null) {
        stdout.writeln('Source: ${criteria.source.toString()}');
      }
      if (criteria.startDate != null) {
        stdout.writeln('Start Date: ${criteria.startDate!.toIso8601String()}');
      }
      if (criteria.endDate != null) {
        stdout.writeln('End Date: ${criteria.endDate!.toIso8601String()}');
      }
      if (criteria.messageContains != null) {
        stdout.writeln('Message: ${criteria.messageContains!}');
      }
      stdout.writeln();
    }

    stdout.writeln('Total matching entries: ${result.totalCount}');
    stdout.writeln();

    stdout.writeln('Count by Level:');
    for (final entry in result.countByLevel.entries) {
      stdout.writeln('${entry.key}: ${entry.value}');
    }

    stdout.writeln();

    stdout.writeln('Top Sources:');
    for (final entry in result.countBySource.entries) {
      stdout.writeln('${entry.key}: ${entry.value}');
    }

    stdout.writeln();

    stdout.writeln('Matches Message:');
    for (final entry in result.countByMessage.entries) {
      stdout.writeln('${entry.key}: ${entry.value}');
    }
  }
}
