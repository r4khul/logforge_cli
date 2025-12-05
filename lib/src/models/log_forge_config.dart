
import 'dart:convert';

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