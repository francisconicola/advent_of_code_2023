import 'dart:async';

import 'package:characters/characters.dart';

Future<int> solveFirstPart(Stream<String> input) async {
  int sum = 0;
  final inputIter = StreamIterator(input);
  if (!await inputIter.moveNext()) {
    throw Exception('Input is empty');
  }
  String botBuffer = '.${inputIter.current}.';
  int lineLength = botBuffer.length;
  String midBuffer = '.' * lineLength;
  String topBuffer = '.' * lineLength;
  final digitPattern = RegExp(r'\d');

  bool hasAdjacentSymbols(
      int start, int end, String topBuffer, String midBuffer, String botBuffer) {
    final adjacentSymbols = <String>{};
    adjacentSymbols.addAll(topBuffer.characters.getRange(start - 1, end + 2));
    adjacentSymbols.addAll(botBuffer.characters.getRange(start - 1, end + 2));
    adjacentSymbols.add(midBuffer.characters.elementAt(start - 1));
    adjacentSymbols.add(midBuffer.characters.elementAt(end + 1));
    adjacentSymbols.removeWhere((char) => char == '.' || digitPattern.hasMatch(char));
    return adjacentSymbols.isNotEmpty;
  }

  bool continueLoop = true;
  while (continueLoop) {
    if (await inputIter.moveNext()) {
      (topBuffer, midBuffer, botBuffer) = (midBuffer, botBuffer, '.${inputIter.current}.');
    } else {
      (topBuffer, midBuffer, botBuffer) = (midBuffer, botBuffer, '.' * lineLength);
      continueLoop = false;
    }
    int? start, end;
    String numberBuffer = '';
    for (var index = 0; index < lineLength; index++) {
      final currentChar = midBuffer.characters.elementAt(index);
      if (digitPattern.hasMatch(currentChar)) {
        start ??= index;
        numberBuffer += currentChar;
      } else if (start != null) {
        end ??= index - 1;
      }
      if (start != null && end != null) {
        if (hasAdjacentSymbols(start, end, topBuffer, midBuffer, botBuffer)) {
          final number = int.parse(numberBuffer);
          sum += number;
        }
        numberBuffer = '';
        start = null;
        end = null;
      }
    }
  }

  return sum;
}

Future<int> solveSecondPart(Stream<String> input) async {
  throw UnimplementedError();
}
