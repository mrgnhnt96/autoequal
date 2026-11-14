import 'package:build_test/build_test.dart';
import 'package:equatable_gen/equatable_gen.dart';
import 'package:equatable_gen/gen/settings.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  final files = {
    'private_class.dart': 'private_class.dart',
    'field_semantics.dart': 'field_semantics.dart',
  };

  for (final MapEntry(key: input, value: output) in files.entries) {
    test('Runs $input', () async {
      final generator = SuccessGenerator.fromBuilder(
        [input],
        [output],
        equatableGenerator,
        options: Settings.defaults(
          autoInclude: input == 'private_class.dart',
        ).toJson(),
      );

      final rw = TestReaderWriter(rootPackage: 'a');
      await rw.testing.loadIsolateSources();
      await generator.test(readerWriter: rw, rootPackage: 'a');
    });
  }
}
