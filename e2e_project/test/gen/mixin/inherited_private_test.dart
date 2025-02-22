import 'package:example/gen/mixin/inherited_private.dart';
import 'package:test/test.dart';

void main() {
  group('$InheritedPrivate', () {
    test('should return the correct property length', () {
      final instance = InheritedPrivate('one', 'two');

      expect(instance.props.length, 1);
    });

    test('should be equal when properties are equal', () {
      final instance = InheritedPrivate('one', 'two');
      final instance2 = InheritedPrivate('-1', 'two');

      expect(instance, instance2);
    });

    test('should not be equal when properties are not equal', () {
      final instance = InheritedPrivate('one', 'two');
      final instance2 = InheritedPrivate('one', 'three');

      expect(instance, isNot(instance2));
    });
  });
}
