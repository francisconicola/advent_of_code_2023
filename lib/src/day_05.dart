import 'dart:async';

class ConversionRule {
  final int targetStart;
  final int sourceStart;
  final int rangeLength;

  const ConversionRule({
    required this.targetStart,
    required this.sourceStart,
    required this.rangeLength,
  });

  int get targetEnd => targetStart + rangeLength;
  int get sourceEnd => sourceStart + rangeLength;
  int get difference => targetStart - sourceStart;
}

Future<int> solveFirstPart(Stream<String> input) async {
  const maxIntValue = -1 >>> 1;
  final mappingTitlePattern = RegExp(r'[a-z]+-to-[a-z]+ map:');
  final conversionRules = <ConversionRule>{};
  final inputIter = StreamIterator(input);
  await inputIter.moveNext();
  final [_, itemsStr] = inputIter.current.split(': ');
  var items = itemsStr.split(' ').map((slice) => int.parse(slice)).toSet();
  await inputIter.moveNext();

  Set<int> applyConversion(Set<int> items, Set<ConversionRule> conversionRules) {
    return items.map((item) {
      for (final rule in conversionRules) {
        if (item >= rule.sourceStart && item < rule.sourceEnd) {
          return item + rule.difference;
        }
      }
      return item;
    }).toSet();
  }

  while (await inputIter.moveNext()) {
    final line = inputIter.current;
    if (mappingTitlePattern.hasMatch(line)) {
      continue;
    }
    if (line.trim().isEmpty) {
      items = applyConversion(items, conversionRules);
      conversionRules.clear();
      continue;
    }
    final [target, source, length] = line.split(' ').map((slice) => int.parse(slice)).toList();
    conversionRules.add(
      ConversionRule(targetStart: target, sourceStart: source, rangeLength: length),
    );
  }
  items = applyConversion(items, conversionRules);
  return items.fold<int>(maxIntValue, (prev, item) => item < prev ? item : prev);
}

Future<int> solveSecondPart(Stream<String> input) async {
  throw UnimplementedError();
}
