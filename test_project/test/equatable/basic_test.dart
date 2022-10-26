import 'package:example/equatable/basic.dart';
import 'package:test/test.dart';

void main() {
  group('$Basic', () {
    test('should return the correct property length', () {
      final instance = Basic('sup dude', two: 'Hows it going');

      expect(3, instance.props.length);
    });

    test('should be equal when the properties are equal', () {
      final instance = Basic('sup dude', two: 'Hows it going');
      final instance2 = Basic('sup dude', two: 'Hows it going');

      expect(instance, instance2);
    });

    test('should not be equal when the properties are not equal', () {
      final instance = Basic('sup dude', two: 'Hows it going');
      final instance2 = Basic('sup dude', two: 'Hows it going', three: 'Good');

      expect(instance, isNot(instance2));
    });
  });
}
