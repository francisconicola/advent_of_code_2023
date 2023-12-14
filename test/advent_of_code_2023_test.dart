import 'dart:io';

import 'package:advent_of_code_2023/args.dart';
import 'package:advent_of_code_2023/src/day_01.dart' as day_01;
import 'package:advent_of_code_2023/src/day_02.dart' as day_02;
import 'package:advent_of_code_2023/src/day_03.dart' as day_03;
import 'package:advent_of_code_2023/src/day_04.dart' as day_04;
import 'package:test/test.dart';

typedef Solver = Future<int> Function(Stream<String>);

Future<void> Function() buildTest(String inputFilepath, Solver solver, Object? expectedSolution) {
  return () async {
    final file = File(inputFilepath);
    final solution = await solver(file.toLineStream());
    expect(solution, expectedSolution);
  };
}

void main() {
  group('day 01', () {
    test('part 1 example', buildTest('input/01/part_1.txt', day_01.solveFirstPart, 142));
    test('part 2 example', buildTest('input/01/part_2.txt', day_01.solveSecondPart, 281));
  });

  group('day 02', () {
    test('part 1 example', buildTest('input/02/part_1.txt', day_02.solveFirstPart, 8));
    test('part 2 example', buildTest('input/02/part_2.txt', day_02.solveSecondPart, 2286));
  });

  group('day 03', () {
    test('part 1 example', buildTest('input/03/part_1.txt', day_03.solveFirstPart, 4361));
    test('part 2 example', buildTest('input/03/part_2.txt', day_03.solveSecondPart, 467835));
  });

  group('day 04', () {
    test('part 1 example', buildTest('input/04/part_1.txt', day_04.solveFirstPart, 13));
    test('part 2 example', buildTest('input/04/part_2.txt', day_04.solveSecondPart, 30));
  });
}
