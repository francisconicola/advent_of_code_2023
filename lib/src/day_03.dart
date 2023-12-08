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

typedef Position = ({int x, int y});

Future<int> solveSecondPart(Stream<String> input) async {
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

  Iterable<Position> getAdjacentGearPositions(
    int currentLineIndex,
    int start,
    int end,
    String topBuffer,
    String midBuffer,
    String botBuffer,
  ) {
    return topBuffer.characters.indexed
        .map((charTuple) => ((x: charTuple.$1, y: currentLineIndex - 1), charTuple.$2))
        .followedBy(botBuffer.characters.indexed
            .map((charTuple) => ((x: charTuple.$1, y: currentLineIndex + 1), charTuple.$2)))
        .followedBy(midBuffer.characters.indexed
            .map((charTuple) => ((x: charTuple.$1, y: currentLineIndex), charTuple.$2)))
        .where((charTuple) =>
            charTuple.$1.x >= start - 1 && charTuple.$1.x <= end + 1 && charTuple.$2 == '*')
        .map((charTuple) => charTuple.$1);
  }

  int extraLines = 2;
  int currentLineIndex = 1;
  final gearsCount = <Position, List<int>>{};
  while (extraLines > 0) {
    if (await inputIter.moveNext()) {
      (topBuffer, midBuffer, botBuffer) = (midBuffer, botBuffer, '.${inputIter.current}.');
    } else {
      (topBuffer, midBuffer, botBuffer) = (midBuffer, botBuffer, '.' * lineLength);
      extraLines--;
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
        final gearPositions =
            getAdjacentGearPositions(currentLineIndex, start, end, topBuffer, midBuffer, botBuffer);
        for (final gearPosition in gearPositions) {
          if (!gearsCount.containsKey(gearPosition)) {
            gearsCount[gearPosition] = [];
          }
          gearsCount[gearPosition]!.add(int.parse(numberBuffer));
        }
        numberBuffer = '';
        start = null;
        end = null;
      }
    }
    sum += gearsCount.entries
        .where((gearEntry) => gearEntry.key.y < currentLineIndex && gearEntry.value.length == 2)
        .fold(0, (prev, gearEntry) => prev + gearEntry.value.first * gearEntry.value.last);
    gearsCount.removeWhere((key, value) => key.y < currentLineIndex);
    currentLineIndex++;
  }

  return sum;
}
