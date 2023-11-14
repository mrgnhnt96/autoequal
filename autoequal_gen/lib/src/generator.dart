library generator;

import 'dart:async' show FutureOr;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:autoequal/autoequal.dart';
import 'package:autoequal_gen/autoequal_gen.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

part 'extensions.dart';

const TypeChecker _equatable = TypeChecker.fromRuntime(Equatable);
const TypeChecker _equatableMixin = TypeChecker.fromRuntime(EquatableMixin);
const TypeChecker _ignore = TypeChecker.fromRuntime(IgnoreAutoequal);
const TypeChecker _include = TypeChecker.fromRuntime(IncludeAutoequal);

/// For class marked with @Autoequal annotation will be generated properties list List<Object>
/// to use it as value for List<Object> props of Equatable object.
/// If mixin=true so a mixin with overrides 'List<Object> get props' will be additionally generated.
final class AutoequalGenerator extends GeneratorForAnnotation<Autoequal> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final ClassElement classElement = _validateElement(element);

    final bool isMixin = annotation.read('mixin').boolValue;

    final Mixin? mixin = _generateMixin(classElement, isMixin: isMixin);

    final List<Spec> generated = [
      if (mixin != null) mixin,
      _generateExtension(
        classElement,
        includeDeprecated: mixin == null,
        isMixinAnnotation: isMixin,
      )
    ];

    final DartEmitter emitter = DartEmitter(useNullSafetySyntax: true);

    return DartFormatter().format([
      for (final Spec spec in generated) spec.accept(emitter).toString()
    ].join('\n'));
  }

  static Extension _generateExtension(
    ClassElement classElement, {
    required bool isMixinAnnotation,
    required bool includeDeprecated,
  }) {
    final String name = classElement.name;
    final PropertyAccessorElement? props = classElement.getGetter('props');

    if (classElement.equatableType.isClass &&
        !isMixinAnnotation &&
        props == null) {
      print('\n[EXT] class "$name" does not have props getter\n');
    }

    return Extension(
      (ExtensionBuilder extensionBuilder) => extensionBuilder
        ..name = '_\$${name}Autoequal'
        ..on = TypeReference(
          (TypeReferenceBuilder typeBuilder) => typeBuilder.symbol = name,
        )
        ..methods.addAll(
          [
            Method(
              (MethodBuilder methodBuilder) => methodBuilder
                ..annotations.addAll([
                  if (includeDeprecated)
                    refer('Deprecated').call(
                      [literalString('Use _\$props instead', raw: true)],
                    ),
                ])
                ..returns = TypeReference(
                  (TypeReferenceBuilder listBuilder) => listBuilder
                    ..symbol = 'List'
                    ..types.add(
                      TypeReference(
                        (TypeReferenceBuilder listTypeBuilder) =>
                            listTypeBuilder
                              ..symbol = 'Object'
                              ..isNullable = true,
                      ),
                    ),
                )
                ..type = MethodType.getter
                ..name = '_autoequalProps'
                ..body = refer('_\$props').code,
            ),
            Method(
              (MethodBuilder methodBuilder) => methodBuilder
                ..returns = TypeReference(
                  (TypeReferenceBuilder listBuilder) => listBuilder
                    ..symbol = 'List'
                    ..types.add(
                      TypeReference(
                        (TypeReferenceBuilder listTypeBuilder) =>
                            listTypeBuilder
                              ..symbol = 'Object'
                              ..isNullable = true,
                      ),
                    ),
                )
                ..type = MethodType.getter
                ..name = '_\$props'
                ..body = literalList(
                  classElement.fields
                      .where((FieldElement field) => _includeField(field))
                      .map(
                        (FieldElement field) => TypeReference(
                          (TypeReferenceBuilder typeBuilder) =>
                              typeBuilder.symbol = field.name,
                        ),
                      ),
                ).code,
            ),
          ],
        ),
    );
  }

  static Mixin? _generateMixin(
    ClassElement classElement, {
    required bool isMixin,
  }) {
    final EquatableType equatableType = classElement.equatableType;

    if (!equatableType.isMixin && !isMixin) {
      return null;
    }

    final bool equatableIsSuper = classElement.equatableIsSuper;

    final bool generateSuperProps =
        equatableIsSuper && classElement.superHasProps;

    if (isMixin || equatableType.isMixin) {
      final String name = classElement.name;

      return Mixin(
        (MixinBuilder mixinBuilder) => mixinBuilder
          ..name = '_\$${name}AutoequalMixin'
          ..on = TypeReference(
            (TypeReferenceBuilder typeBuilder) =>
                typeBuilder.symbol = equatableType.equatableName,
          )
          ..methods.add(
            Method(
              (MethodBuilder methodBuilder) => methodBuilder
                ..annotations.add(refer('override'))
                ..returns = TypeReference(
                  (TypeReferenceBuilder listBuilder) => listBuilder
                    ..symbol = 'List'
                    ..types.add(
                      TypeReference(
                        (TypeReferenceBuilder listTypeBuilder) =>
                            listTypeBuilder
                              ..symbol = 'Object'
                              ..isNullable = true,
                      ),
                    ),
                )
                ..type = MethodType.getter
                ..name = 'props'
                ..body = generateSuperProps
                    ? literalList(
                        [
                          refer('super').property('props').spread,
                          refer('_\$${name}Autoequal')
                              .type
                              .newInstance([refer('this').asA(refer(name))])
                              .property('_\$props')
                              .spread,
                        ],
                      ).code
                    : refer('_\$${name}Autoequal')
                        .type
                        .newInstance([refer('this').asA(refer(name))])
                        .property('_\$props')
                        .code,
            ),
          ),
      );
    }

    return null;
  }

  static bool _includeField(FieldElement element) {
    if (element.isStatic) {
      return false;
    }

    if (element.name == 'props') {
      return false;
    }

    if (_ignore.hasAnnotationOfExact(element)) {
      return false;
    }

    if (element.getter == null) {
      return false;
    }

    if (_include.hasAnnotationOfExact(element)) {
      return true;
    }

    if (_ignore.hasAnnotationOfExact(element.getter!)) {
      return false;
    }

    if (_include.hasAnnotationOfExact(element.getter!)) {
      return true;
    }

    if (element.isSynthetic) {
      if (settings.includeGetters) {
        return true;
      }

      return false;
    }

    return true;
  }

  static ClassElement _validateElement(Element element) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '$element is not a ClassElement',
        element: element,
      );
    }

    if (!element.usesEquatable) {
      final superIsEquatable = element.equatableIsSuper;

      if (!superIsEquatable) {
        throw InvalidGenerationSourceError(
          'Class ${element.name} is not a subclass of Equatable or EquatableMixin',
          element: element,
        );
      }
    }

    return element;
  }
}

enum EquatableType {
  class_,
  mixin,
  none,
}
