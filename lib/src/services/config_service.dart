import 'dart:convert';
import 'dart:io';
import 'package:logforge_cli/src/models/log_forge_config.dart';


String _configFilePath() {
  final home =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
  return '$home/.logforge/config.json';
}

Future<LogForgeConfig> loadConfig() async {
  final path = _configFilePath();
  final file = File(path);

  if (!await file.exists()) {
    return LogForgeConfig.empty;
  }

  final content = await file.readAsString();
  final decoded = jsonDecode(content);
  late final Map<String, dynamic> jsonMap;

  if (decoded is String) {
    jsonMap = jsonDecode(decoded) as Map<String, dynamic>;
  } else {
    jsonMap = decoded as Map<String, dynamic>;
  }

  return LogForgeConfig.fromMap(jsonMap);
}

Future<void> saveConfig(LogForgeConfig config) async {
  final path = _configFilePath();
  final file = File(path);

  await file.parent.create(recursive: true);
  final content = config.toJson();
  await file.writeAsString(content);
}
