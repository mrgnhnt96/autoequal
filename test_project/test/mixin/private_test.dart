import 'package:example/mixin/private.dart';
import 'package:test/test.dart';

void main() {
  group('$Private', () {
    test('should return the correct property length', () {
      final instance = Private('sup dude', two: 'Hows it going');

      expect(3, instance.props.length);
    });

    test('should be equal when the properties are equal', () {
      final instance1 = Private('sup dude', two: 'Hows it going');
      final instance2 = Private('sup dude', two: 'Hows it going');

      expect(instance1, instance2);
    });

    test('should not be equal when the properties are not equal', () {
      final instance1 = Private('sup dude', two: 'Hows it going');
      final instance2 =
          Private('sup dude', two: 'Hows it going', three: 'good');

      expect(instance1, isNot(instance2));
    });
  });
}
