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
  int sum = 0;
  final cardPattern = RegExp(r'Card\s+(\d+)');
  final copiedCardsStack = <int, int>{};
  await for (final line in input) {
    final [cardStr, numbersStr] = line.split(':');
    final int card;
    try {
      card = int.parse(cardPattern.firstMatch(cardStr)!.group(1)!);
    } catch (ex) {
      throw Exception('Failed to parse current card');
    }
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
    final currentCardCount = (copiedCardsStack[card] ?? 0) + 1;
    sum += currentCardCount;
    for (var i = 1; i <= ownedWinningCount; i++) {
      final copiedCard = card + i;
      copiedCardsStack[copiedCard] = (copiedCardsStack[copiedCard] ?? 0) + currentCardCount;
    }
  }
  return sum;
}
