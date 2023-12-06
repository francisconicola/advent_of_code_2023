import 'dart:io';

import 'package:advent_of_code_2023/args.dart';
import 'package:advent_of_code_2023/src/day_01.dart' as day_01;
import 'package:test/test.dart';

void main() {
  group('day 01', () {
    test('part 1 example', () async {
      final file = File('input/01/part_1.txt');
      final solution = await day_01.solveFirstPart(file.toLineStream());
      expect(solution, 142);
    });
    test('part 2 example', () async {
      final file = File('input/01/part_2.txt');
      final solution = await day_01.solveSecondPart(file.toLineStream());
      expect(solution, 281);
    });
  });
}
