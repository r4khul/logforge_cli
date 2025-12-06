import 'package:logforge/src/models/log_entry.dart';
import 'package:logforge/src/models/log_filter_criteria.dart';

bool matchesCriteria(LogEntry entry, LogFilterCriteria criteria) {
  if (criteria.level != null && entry.level != criteria.level) {
    return false;
  }

  if (criteria.source != null && entry.source != criteria.source) {
    return false;
  }

  if (criteria.startDate != null &&
      entry.timestamp.isBefore(criteria.startDate!)) {
    return false;
  }

  if (criteria.endDate != null && entry.timestamp.isAfter(criteria.endDate!)) {
    return false;
  }

  if (criteria.messageContains != null &&
      !entry.message.contains(criteria.messageContains!)) {
    return false;
  }

  return true;
}
