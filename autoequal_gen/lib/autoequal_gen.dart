library autoequal_gen;

import 'package:autoequal_gen/src/settings.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

/// Settings for autoequal_gen
late Settings settings;

/// The entry point for the autoequal_gen generator.
Builder autoequalGenerator(BuilderOptions options) {
  settings = Settings.fromConfig(options.config);

  return SharedPartBuilder(
    [
      AutoequalGenerator(),
    ],
    'autoequal_gen',
  );
}
