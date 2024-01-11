library autoequal_gen;

import 'package:autoequal_gen/gen/settings.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

/// The entry point for the autoequal_gen generator.
Builder autoequalGenerator(BuilderOptions options) {
  final settings = Settings.fromJson(options.config);

  return SharedPartBuilder(
    [
      AutoequalGenerator(settings),
    ],
    'autoequal_gen',
  );
}
