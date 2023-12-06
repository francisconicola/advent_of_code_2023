import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

class ArgsWrapper {
  final int day;
  final int part;
  final File input;

  const ArgsWrapper({
    required this.day,
    required this.part,
    required this.input,
  });

  factory ArgsWrapper.fromResult(ArgResults result) {
    final day = int.tryParse(result['day']);
    if (day == null || day <= 0 || day > 25) {
      throw ArgumentError('Option day must be an integer between 1 and 25.');
    }
    final part = int.tryParse(result['part']);
    if (part == null || part <= 0 || part > 2) {
      throw ArgumentError('Option part must be an integer between 1 and 2.');
    }
    final inputPath = result['input'];
    final input = File(inputPath);
    if (!input.existsSync()) {
      throw ArgumentError('Input file \'$inputPath\' does not exists.');
    }
    return ArgsWrapper(
      day: day,
      part: part,
      input: input,
    );
  }
}

ArgParser buildArgumentParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'shows this help section',
      negatable: false,
    )
    ..addOption(
      'day',
      abbr: 'd',
      mandatory: true,
      help: 'selects the challenge to run',
    )
    ..addOption(
      'part',
      abbr: 'p',
      mandatory: true,
      help: 'selects the part of the challenge (1 or 2)',
    )
    ..addOption(
      'input',
      abbr: 'i',
      mandatory: true,
      help: 'the path of the input file to use',
    );
}

ArgsWrapper parseArguments(List<String> arguments) {
  final parser = buildArgumentParser();
  try {
    final result = parser.parse(arguments);
    if (result['help'] == true) {
      print('ADVENT OF CODE 2023!!!\n');
      print(parser.usage);
      exit(0);
    }
    return ArgsWrapper.fromResult(result);
  } on ArgumentError catch (ex) {
    stderr.writeln(ex);
    exit(1);
  } on FormatException catch (ex) {
    stderr.writeln(ex.message);
    exit(2);
  }
}

extension FileToLineStream on File {
  Stream<String> toLineStream() => openRead().transform(utf8.decoder).transform(LineSplitter());
}
