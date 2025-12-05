import 'package:args/command_runner.dart';

class ConfigCommand extends Command<void>{
  @override
  final String name = 'config';
  @override
  final String description = 'allows config';

}