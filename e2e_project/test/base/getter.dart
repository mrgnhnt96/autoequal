import 'package:example/gen/{REPLACE}/getter.dart';
import 'package:test/test.dart';

void main() {
  group('$Getter', () {
    test('should return the correct property length', () {
      final instance = Getter();

      expect(0, instance.props.length);
    });

    test('should be equal when properties match', () {
      final instance = Getter();
      final instance2 = Getter();

      expect(instance, instance2);
    });
  });
}
