import 'package:args/command_runner.dart';

class HelloCommand extends Command<void> {
  @override
  final String name = 'hello';

  @override
  final String description = 'Prints a greeting with an optional name.';

  HelloCommand() {
    argParser.addOption(
      'name',
      abbr: 'n',
      help: 'Name to greet.',
      valueHelp: 'name',
      defaultsTo: 'world',
    );
  }

  @override
  Future<void> run() async {
    final String name = argResults!['name'] as String;
    print('Hello, $name!');
  }
}
