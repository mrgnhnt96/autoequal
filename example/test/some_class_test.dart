import 'package:example/some_class.dart';
import 'package:test/test.dart';

void main() {
  test("equal EXPECT to be equal", () {
    final one = SomeClass(id: "1", ignoredField: "one");
    final two = SomeClass(id: "1", ignoredField: "two");

    expect(one, equals(two));
  });

  test("non equal EXPECT to be not equal", () {
    final one = SomeClass(id: "1");
    final two = SomeClass(id: "2");

    expect(one, isNot(equals(two)));
  });
}