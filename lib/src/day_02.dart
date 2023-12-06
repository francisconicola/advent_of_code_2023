import 'dart:math';

Future<int> solveFirstPart(Stream<String> input) async {
  int sum = 0;
  final gamePattern = RegExp(r'Game (\d+)');
  final [redPattern, greenPattern, bluePattern] =
      ['red', 'green', 'blue'].map((color) => RegExp('(\\d+) $color')).toList();
  int matchNumber(String input, RegExp pattern) {
    return int.tryParse(pattern.firstMatch(input)?.group(1) ?? '') ?? 0;
  }

  const totalRed = 12;
  const totalGreen = 13;
  const totalBlue = 14;
  await for (final line in input) {
    final [gameString, sets] = line.split(':');
    final game = matchNumber(gameString, gamePattern);
    if (game == 0) {
      throw Exception('Bad format for line \'$line\'');
    }
    int maxRed = 0;
    int maxGreen = 0;
    int maxBlue = 0;
    for (final set in sets.split(';')) {
      final red = matchNumber(set, redPattern);
      final green = matchNumber(set, greenPattern);
      final blue = matchNumber(set, bluePattern);
      maxRed = max(red, maxRed);
      maxGreen = max(green, maxGreen);
      maxBlue = max(blue, maxBlue);
    }
    if (maxRed <= totalRed && maxGreen <= totalGreen && maxBlue <= totalBlue) {
      sum += game;
    }
  }
  return sum;
}

Future<int> solveSecondPart(Stream<String> input) async {
  throw UnimplementedError();
}
