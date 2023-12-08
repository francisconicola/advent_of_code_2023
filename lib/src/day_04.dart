import 'dart:math';

Future<int> solveFirstPart(Stream<String> input) async {
  int sum = 0;
  await for (final line in input) {
    final [_, numbersStr] = line.split(':');
    final [winningNumbersStr, ownedNumbersStr] = numbersStr.split('|');
    final winningNumbers = winningNumbersStr
        .split(' ')
        .where((number) => number.isNotEmpty)
        .map((number) => int.parse(number));
    final ownedNumbers = ownedNumbersStr
        .split(' ')
        .where((number) => number.isNotEmpty)
        .map((number) => int.parse(number));
    final ownedWinningCount =
        ownedNumbers.where((number) => winningNumbers.contains(number)).length;
    sum += ownedWinningCount == 0 ? 0 : pow(2, ownedWinningCount - 1) as int;
  }
  return sum;
}

Future<int> solveSecondPart(Stream<String> input) async {
  throw UnimplementedError();
}
