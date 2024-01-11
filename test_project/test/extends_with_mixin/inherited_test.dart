import 'package:example/extends_with_mixin/inherited.dart';
import 'package:test/test.dart';

void main() {
  group('$Inherited', () {
    test('should return the correct property length', () {
      final instance = Inherited('one', 'two');

      expect(2, instance.props.length);
    });

    test('should be equal when the properties are equal', () {
      final instance = Inherited('one', 'two');
      final instance2 = Inherited('one', 'two');

      expect(instance, instance2);
    });

    test('should not be equal when the properties are not equal', () {
      final instance = Inherited('one', 'two');
      final instance2 = Inherited('one', 'three');

      expect(instance, isNot(instance2));
    });
  });
}
