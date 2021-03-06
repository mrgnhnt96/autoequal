import 'package:example/some_class.dart';
import 'package:test/test.dart';

void main() {
  test('equal EXPECT to be equal', () {
    final one = SomeClassMix(value: '1', ignored: 'one', optional: 'one');
    final two = SomeClassMix(value: '1', ignored: 'two', optional: 'one');

    expect(one, equals(two));
  });

  test('non equal EXPECT to be not equal by required', () {
    final one = SomeClassMix(value: '1');
    final two = SomeClassMix(value: '2');

    expect(one, isNot(equals(two)));
  });

  test('non equal EXPECT to be not equal by optional', () {
    final one = SomeClassMix(value: '1', optional: 'one');
    final two = SomeClassMix(value: '1', optional: 'two');

    expect(one, isNot(equals(two)));
  });
}
