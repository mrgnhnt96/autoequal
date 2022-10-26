library autoequal_gen;

import 'package:autoequal_gen/src/settings.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

late Settings settings;

Builder autoequalGenerator(BuilderOptions options) {
  settings = Settings.fromConfig(options.config);

  return SharedPartBuilder(
    [
      AutoequalGenerator(),
    ],
    'autoequal_gen',
  );
}
