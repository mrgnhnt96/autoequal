import 'package:example/equatable/include_getter.dart';
import 'package:test/test.dart';

void main() {
  group('$IncludeGetter', () {
    test('should return the correct property length', () {
      final instance = IncludeGetter();

      expect(1, instance.props.length);
    });

    test('should be equal when properties are equal', () {
      final instance = IncludeGetter();
      final instance2 = IncludeGetter();

      expect(instance, instance2);
    });
  });
}
