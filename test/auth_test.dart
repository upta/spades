import 'package:test/test.dart';

void main() {
  test('Should work', () {
    expect(1, 1);
  });

  test('Should fail', () {
    expect(1, 0);
  });
}