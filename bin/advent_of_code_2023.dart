import 'package:advent_of_code_2023/args.dart';
import 'package:advent_of_code_2023/src/day_01.dart' as day_01;

Future<void> main(List<String> arguments) async {
  final args = parseArguments(arguments);
  final inputStream = args.input.toLineStream();
  final solution = await switch ((args.day, args.part)) {
    (1, 1) => day_01.solveFirstPart(inputStream),
    (1, 2) => day_01.solveSecondPart(inputStream),
    _ => throw Exception('Solution not found'),
  };
  print('Day ${args.day} - Part ${args.part}');
  print('The solution is: $solution');
}
