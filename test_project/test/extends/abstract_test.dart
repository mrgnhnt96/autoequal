import 'package:example/extends/abstract.dart';
import 'package:test/test.dart';

class _Impl extends Abstract {
  _Impl(super.one);
}

void main() {
  group('$Abstract', () {
    test('should return the correct property length', () {
      final instance = _Impl('one');

      expect(1, instance.props.length);
    });

    test('should be equal when properties are equal', () {
      final instance = _Impl('one');
      final instance2 = _Impl('one');

      expect(instance, instance2);
    });

    test('should not be equal when properties are not equal', () {
      final instance = _Impl('one');
      final instance2 = _Impl('two');

      expect(instance, isNot(instance2));
    });
  });
}
