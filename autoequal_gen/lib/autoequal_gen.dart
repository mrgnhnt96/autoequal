library autoequal_gen;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

Builder autoequalGenerator(BuilderOptions options) =>
    SharedPartBuilder([AutoequalGenerator()], 'autoequal_gen');
