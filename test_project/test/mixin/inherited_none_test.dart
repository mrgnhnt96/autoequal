import 'package:example/mixin/inherited_none.dart';
import 'package:test/test.dart';

void main() {
  group('$InheritedNone', () {
    test('should return the correct property length', () {
      final instance = InheritedNone('one', 'two');

      expect(1, instance.props.length);
    });

    test('should be equal when the properties are equal', () {
      final instance = InheritedNone('one', 'two');
      final instance2 = InheritedNone('one', 'two');

      expect(instance, instance2);
    });

    test('should not be equal when the properties are not equal', () {
      final instance = InheritedNone('one', 'two');
      final instance2 = InheritedNone('two', 'three');

      expect(instance, isNot(instance2));
    });
  });
}
