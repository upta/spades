import 'package:flutter/foundation.dart';

ScoreResult calculate(ScoreInput input) {
  if (input.bid == 0) {
      return ScoreResult(
        bags: input.tricks,
        points: input.tricks == 0
          ? 100
          : -100,
      );
  }

  if (input.tricks < input.bid) {
    return ScoreResult(
      bags: 0,
      points: input.bid * -10,
    );
  }

  final int bags = input.tricks - input.bid;

  return ScoreResult(
    bags: bags,
    points: (input.bid * 10) + bags,
  );

}

@immutable
class ScoreInput {
  ScoreInput({
    @required this.bid,
    @required this.tricks
  });

  final int bid;
  final int tricks;
}

@immutable
class ScoreResult {
  ScoreResult({
    @required this.points,
    @required this.bags
  });

  final int points;
  final int bags;
}