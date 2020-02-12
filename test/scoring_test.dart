import 'package:test/test.dart';
import 'package:spades/scoring.dart';

void main() {
  group('Scoring -> calculate', () {
    test('should correctly give positive points', () {
      final input = {
        ScoreInput(bid: 5, tricks: 5) : 50,
        ScoreInput(bid: 6, tricks: 7) : 61,
        ScoreInput(bid: 1, tricks: 5) : 14
      };

      input.forEach((key, value) {
        final result = calculate(key);

        expect(result.points, value, reason: 'Bid of ${key.bid} should result in a score of $value');
      });
    });

    test('should give bags for over bidding', () {
      final input = {
        ScoreInput(bid: 5, tricks: 5) : 0,
        ScoreInput(bid: 6, tricks: 7) : 1,
        ScoreInput(bid: 1, tricks: 5) : 4
      };

      input.forEach((key, value) {
        final result = calculate(key);

        expect(result.bags, value, reason: 'Bid of ${key.bid} with tricks of ${key.tricks} should result in $value bags');
      });
    });

    test('should give negative points for under bidding', () {
      final input = {
        ScoreInput(bid: 5, tricks: 4) : -50,
        ScoreInput(bid: 3, tricks: 1) : -30,
        ScoreInput(bid: 8, tricks: 0) : -80
      };

      input.forEach((key, value) {
        final result = calculate(key);

        expect(result.points, value, reason: 'A missed bid of ${key.bid} should result in a score of $value');
      });
    });

    test('should give no bags for a missed bid', () {
      final input = {
        ScoreInput(bid: 5, tricks: 2),
        ScoreInput(bid: 2, tricks: 1),
        ScoreInput(bid: 8, tricks: 6)
      };

      input.forEach((key) {
        final result = calculate(key);

        expect(result.bags, 0, reason: 'A missed bid should give no bags');
      });
    });

    test('should give points and no bags for a successful nil', () {
      final input = ScoreInput(bid: 0, tricks: 0);

      final result = calculate(input);

      expect(result.points, 100, reason: 'A successful nil should give 100 points');
      expect(result.bags, 0, reason: 'A successful nil should give no bags');
    });

    test('should give negative points and point-free bags for an unsuccessful nil', () {
      final input = ScoreInput(bid: 0, tricks: 2);

      final result = calculate(input);

      expect(result.points, -100, reason: 'An unsuccessful nil should give -100 points');
      expect(result.bags, 2, reason: 'A unsuccessful nil should give bags (but no points) for every trick taken');
    });
  });
}