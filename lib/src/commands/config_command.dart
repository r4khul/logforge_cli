import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logforge_cli/src/services/config_service.dart';

class ConfigCommand extends Command<void> {
  @override
  final String name = 'config';
  @override
  final String description = 'Manages LogForge Configurations.';

  ConfigCommand() {
    addSubcommand(_ConfigShowCommand());
    addSubcommand(_ConfigSetCommand());
  }
}

class _ConfigShowCommand extends Command<void> {
  @override
  final String name = 'show';
  @override
  final String description = 'Shows the current configuration.';

  @override
  Future<void> run() async {
    final config = await loadConfig();
    stdout.writeln('Current LogForge configuration:');
    stdout.writeln('defaultLogDir: ${config.defaultLogDir ?? 'not set'}');
    stdout.writeln('defaultLevel: ${config.defaultLevel ?? 'not set'}');
    stdout.writeln();
  }
}

class _ConfigSetCommand extends Command<void> {
  @override
  final String name = 'set';
  @override
  final String description = 'Sets a configuration as a key value pair.';

  _ConfigSetCommand() {
    argParser
      ..addOption(
        'key',
        help: 'Configuration key (defaultLogDir, defaultLevel).',
        valueHelp: 'KEY',
      )
      ..addOption('value', help: 'Value to set.', valueHelp: 'VALUE');
  }

  @override
  Future<void> run() async {
    final key = argResults?['key'] as String?;
    final value = argResults?['value'] as String?;

    if (key == null || value == null) {
      throw UsageException('Both --key and --value are required.', usage);
    }

    var config = await loadConfig();

    switch (key) {
      case 'defaultLogDir':
        config = config.copyWith(defaultLogDir: value);
        break;
      case 'defaultLevel':
        config = config.copyWith(defaultLevel: value);
        break;
      default:
        throw UsageException('Unknown key: $key', usage);
    }

    await saveConfig(config);
    stdout.writeln('Updated configuration: $key = $value');
  }
}
