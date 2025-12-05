import 'dart:convert';
import 'dart:io';

class LogForgeConfig {
  final String? defaultLogDir;
  final String? defaultLevel;

  const LogForgeConfig({this.defaultLevel, this.defaultLogDir});

  static const empty = LogForgeConfig();

  LogForgeConfig copyWith({String? defaultLogDir, String? defaultLevel}) {
    return LogForgeConfig(
      defaultLogDir: defaultLogDir ?? this.defaultLogDir,
      defaultLevel: defaultLevel ?? this.defaultLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'defaultLogDir': defaultLogDir,
      'defaultLevel': defaultLevel,
    };
  }

  factory LogForgeConfig.fromMap(Map<String, dynamic> map) {
    return LogForgeConfig(
      defaultLogDir: map['defaultLogDir'] != null
          ? map['defaultLogDir'] as String
          : null,
      defaultLevel: map['defaultLevel'] != null
          ? map['defaultLevel'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogForgeConfig.fromJson(String source) =>
      LogForgeConfig.fromMap(json.decode(source) as Map<String, dynamic>);
}

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
  final jsonMap = jsonDecode(content) as Map<String, dynamic>;

  return LogForgeConfig.fromMap(jsonMap);
}

Future<void> saveConfig(LogForgeConfig config) async {
  final path = _configFilePath();
  final file = File(path);

  await file.parent.create(recursive: true);
  final content = jsonEncode(config.toJson());
  await file.writeAsString(content);
}
