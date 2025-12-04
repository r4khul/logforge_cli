import 'dart:io';
import 'dart:convert';

Stream<String> readFileStream(final String path) {
  final file = File(path);

  final byteStream = file.openRead();
  final lineStream = byteStream
      .transform(const Utf8Decoder())
      .transform(const LineSplitter());

  return lineStream;
}
