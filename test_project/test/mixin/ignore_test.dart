import 'package:example/mixin/ignore.dart';
import 'package:test/test.dart';

void main() {
  group('$Ignore', () {
    test('should return the correct property length', () {
      final instance = Ignore('sup dude', two: 'Hows it going');

      expect(2, instance.props.length);
    });

    test('should be equal when the properties are equal', () {
      final instance1 = Ignore('sup dude', two: 'Hows it going');
      final instance2 = Ignore('sup dude', two: 'Hows it going');

      expect(instance1, instance2);
    });

    test('should not be equal when the properties are not equal', () {
      final instance1 = Ignore('sup dude', two: 'Hows it going');
      final instance2 = Ignore('sup dude', two: 'Hows it going', three: 'Good');

      expect(instance1, isNot(instance2));
    });

    test('should be equal when ignored property is not equal', () {
      final instance1 = Ignore('sup dude', two: 'Hows it going');
      final instance2 = Ignore('dude sup', two: 'Hows it going');

      expect(instance1, instance2);
    });
  });
}
