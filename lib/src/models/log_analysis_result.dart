
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalCount': totalCount,
      'countByLevel': countByLevel,
      'countBySource': countBySource,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory LogAnalysisResult.fromJson(String source) =>
      LogAnalysisResult.fromMap(json.decode(source) as Map<String, dynamic>);
}
