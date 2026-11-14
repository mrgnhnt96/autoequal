import 'package:autoequal_gen/autoequal_gen.dart';
import 'package:autoequal_gen/gen/settings.dart';
import 'package:build_test/build_test.dart';
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
        autoequalGenerator,
        options: Settings.defaults(
          autoInclude: input == 'private_class.dart',
        ).toJson(),
      );

      final readerWriter = TestReaderWriter(rootPackage: 'a');
      await readerWriter.testing.loadIsolateSources();
      await generator.test(readerWriter: readerWriter, rootPackage: 'a');
    });
  }
}
