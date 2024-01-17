import 'package:autoequal_gen/autoequal_gen.dart';
import 'package:autoequal_gen/gen/settings.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  final files = {'private_class.dart': 'private_class.dart'};

  for (final MapEntry(key: input, value: output) in files.entries) {
    test('Runs $input', () async {
      final generator = SuccessGenerator.fromBuilder(
        [input],
        [output],
        autoequalGenerator,
        options: Settings.defaults(
          autoInclude: true,
        ).toJson(),
      );

      await generator.test();
    });
  }
}
