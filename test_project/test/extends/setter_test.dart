import 'package:example/extends/setter.dart';
import 'package:test/test.dart';

void main() {
  group('$Setter', () {
    test('should return the correct property length', () {
      final instance = Setter();

      expect(0, instance.props.length);
    });

    test('should be equal when the properties are equal', () {
      final instance1 = Setter();
      final instance2 = Setter();

      expect(instance1, instance2);
    });
  });
}
