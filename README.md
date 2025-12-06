# LogForge CLI

A command-line tool for processing and analyzing logs, written in Dart as a practice project for building efficient CLI applications. It focuses on streaming large log files, applying filters, and performing basic aggregations with performance in mind, using isolates for parallel processing where possible.

[Package on pub.dev](https://pub.dev/packages/logforge)

## Overview

This project started as a simple Dart CLI template and has grown to include core functionality for log parsing and filtering. The main goals are low memory usage for handling large files and basic extensibility for common log tasks. It currently supports filtering by log level or message patterns, with plans for more advanced features like custom parsers and output formats.

The code is structured following standard Dart conventions:
- Entry point in `bin/` for the CLI executable.
- Library logic in `lib/`, including core classes for processing.
- Unit tests in `test/` to verify functionality.

Recent developments include adding message-based filtering and leveraging Dart isolates to parallelize certain operations, improving throughput for intensive tasks.

## Installation

### Prerequisites
- Dart SDK 3.0 or higher.

### Global Activation
Install and activate the package globally:

```
dart pub global activate logforge
```

Add the pub cache bin directory to your PATH if not already set:

```
export PATH="$PATH:$HOME/.pub-cache/bin"
```

### Local Setup
Clone the repository and prepare dependencies:

```
git clone https://github.com/r4khul/logforge_cli.git
cd logforge_cli
dart pub get
dart run bin/logforge.dart --help
```

## Usage

Run `logforge` with subcommands for different operations. Input can be from files, stdin, or piped sources.

### Basic Commands

- **filter**: Stream logs and apply filters.
  ```
  logforge filter app.log --level ERROR --message "timeout"
  ```
  Options:
  - `--level`: Filter by log level (e.g., DEBUG, INFO, WARN, ERROR).
  - `--message`: Regex pattern to match in log messages.

- **process**: Basic parsing and output (uses isolates for parallelism).
  ```
  cat large.log | logforge process --output summary
  ```
  Options:
  - `--output`: Format like raw, summary, or json.

For full options, use:
```
logforge --help
```

Example pipeline:
```
tail -f /var/log/syslog | logforge filter --level WARN | logforge process --output json > filtered.json
```

## Project Structure

- `bin/logforge.dart`: Main CLI entry point with argument parsing using the `args` package.
- `lib/logforge.dart`: Exports core library components.
- `lib/src/`:
  - Processing logic, including stream handlers and filter implementations.
  - Isolate management for parallel tasks.
- `test/`: Unit tests for filters and processors.
- `pubspec.yaml`: Dependencies (minimal: args for CLI).
- `analysis_options.yaml`: Linting rules.

The use of isolates helps with concurrency, especially for filtering large streams without blocking the main thread.

## Building and Testing

Fetch dependencies:
```
dart pub get
```

Lint and format:
```
dart analyze
dart format .
```

Run tests:
```
dart test
```

Compile to executable:
```
dart compile exe bin/logforge.dart -o logforge
```

## Dependencies

- `args`: For command-line parsing.

No heavy dependencies to keep it lightweight.

## Contributing

Fork the repo, make changes on a feature branch, and submit a pull request. Focus on performance improvements or new filters. Run tests before submitting.

See [issues](https://github.com/r4khul/logforge_cli/issues) for open tasks.

## License

MIT License - see [LICENSE](LICENSE).

## Changelog

### Initial Releases
- Basic command structure and filtering.
- Added isolates for parallel processing.
- Message filtering support.

Check the [pub.dev changelog](https://pub.dev/packages/logforge/changelog) for detailed updates.