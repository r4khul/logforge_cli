import 'dart:convert';

import 'package:logforge_cli/src/models/log_level.dart';

class LogAnalysisResult {
  final int totalCount;
  final Map<LogLevel, int> countByLevel;
  final Map<String, int> countBySource;
  final Map<String, int> countByMessage;

  LogAnalysisResult({
    required this.totalCount,
    required this.countByLevel,
    required this.countBySource,
    required this.countByMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalCount': totalCount,
      'countByLevel': countByLevel,
      'countBySource': countBySource,
      'countByMessage': countByMessage,
    };
  }

  factory LogAnalysisResult.fromMap(Map<String, dynamic> map) {
    return LogAnalysisResult(
      totalCount: map['totalCount'] as int,
      countByLevel: Map<LogLevel, int>.from(
        (map['countByLevel'] as Map<LogLevel, int>),
      ),
      countBySource: Map<String, int>.from(
        (map['countBySource'] as Map<String, int>),
      ),
      countByMessage: Map<String, int>.from(
        (map['countByMessage'] as Map<String, int>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LogAnalysisResult.fromJson(String source) =>
      LogAnalysisResult.fromMap(json.decode(source) as Map<String, dynamic>);
}
