import 'package:logforge_cli/src/models/log_level.dart';

class LogFilterCriteria {
  final LogLevel? level;
  final String? source;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? messageContains;

  LogFilterCriteria({
    this.level,
    this.source,
    this.startDate,
    this.endDate,
    this.messageContains,
  });
}
