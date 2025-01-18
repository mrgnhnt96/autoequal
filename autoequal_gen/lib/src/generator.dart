library;

import 'dart:async' show FutureOr;

import 'package:autoequal_gen/gen/settings.dart';
import 'package:autoequal_gen/src/visitors/class_visitor.dart';
import 'package:autoequal_gen/src/writers/write_file.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

/// For class marked with @Autoequal annotation will be generated properties list List<Object>
/// to use it as value for List<Object> props of Equatable object.
/// If mixin=true so a mixin with overrides 'List<Object> get props' will be additionally generated.
final class AutoequalGenerator extends Generator {
  AutoequalGenerator(this.settings);

  final Settings settings;

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    final visitor = ClassVisitor(settings);

    library.element.accept(visitor);

    final emitter = DartEmitter(useNullSafetySyntax: true);

    final generated = writeFile(visitor.nodes);

    return generated.map((e) => e.accept(emitter)).join('\n');
  }
}
