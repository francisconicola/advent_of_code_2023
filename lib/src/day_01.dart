import 'package:characters/characters.dart';

Future<int> solveFirstPart(Stream<String> input) async {
  int sum = 0;
  final digitPattern = RegExp(r'\d');
  await for (final line in input) {
    int? firstDigit, lastDigit;
    for (final char in line.characters) {
      if (digitPattern.hasMatch(char)) {
        lastDigit = int.parse(char);
        firstDigit ??= lastDigit;
      }
    }
    if (lastDigit == null || firstDigit == null) {
      throw Exception('No valid digits in line \'$line\'');
    }
    sum += firstDigit * 10 + lastDigit;
  }
  return sum;
}

Future<int> solveSecondPart(Stream<String> input) async {
  const digitWords = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
  ];
  int sum = 0;
  final digitPattern = RegExp(r'\d');
  await for (final line in input) {
    int? firstDigit, lastDigit;
    String buffer = '';
    for (final char in line.characters) {
      if (digitPattern.hasMatch(char)) {
        lastDigit = int.parse(char);
        firstDigit ??= lastDigit;
        buffer = '';
      } else {
        buffer += char;
        int numberFound = -1;
        for (int start = buffer.length - 1; start >= 0; start--) {
          final bufferSlice = buffer.substring(start, buffer.length);
          numberFound = digitWords.indexWhere((digitWord) => bufferSlice.contains(digitWord));
          if (numberFound >= 0) {
            lastDigit = numberFound;
            firstDigit ??= lastDigit;
            break;
          }
        }
      }
    }
    if (lastDigit == null || firstDigit == null) {
      throw Exception('No valid digits in line \'$line\'');
    }
    sum += firstDigit * 10 + lastDigit;
  }
  return sum;
}
