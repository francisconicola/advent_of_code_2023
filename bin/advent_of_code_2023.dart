import 'package:advent_of_code_2023/args.dart';
import 'package:advent_of_code_2023/src/day_01.dart' as day_01;
import 'package:advent_of_code_2023/src/day_02.dart' as day_02;
import 'package:advent_of_code_2023/src/day_03.dart' as day_03;
import 'package:advent_of_code_2023/src/day_04.dart' as day_04;
import 'package:advent_of_code_2023/src/day_05.dart' as day_05;

Future<void> main(List<String> arguments) async {
  final args = parseArguments(arguments);
  final inputStream = args.input.toLineStream();
  final solution = await switch ((args.day, args.part)) {
    (1, 1) => day_01.solveFirstPart(inputStream),
    (1, 2) => day_01.solveSecondPart(inputStream),
    (2, 1) => day_02.solveFirstPart(inputStream),
    (2, 2) => day_02.solveSecondPart(inputStream),
    (3, 1) => day_03.solveFirstPart(inputStream),
    (3, 2) => day_03.solveSecondPart(inputStream),
    (4, 1) => day_04.solveFirstPart(inputStream),
    (4, 2) => day_04.solveSecondPart(inputStream),
    (5, 1) => day_05.solveFirstPart(inputStream),
    (5, 2) => day_05.solveSecondPart(inputStream),
    _ => throw Exception('Solution not found'),
  };
  print('Day ${args.day} - Part ${args.part}');
  print('The solution is: $solution');
}
