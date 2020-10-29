import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

import 'package:autoequal/autoequal.dart';

class AutoequalGenerator extends GeneratorForAnnotation<Autoequal> {
  final _ignore = const TypeChecker.fromRuntime(IgnoreAutoequal);
  final _equatable = const TypeChecker.fromRuntime(Equatable);
  final _equatableMixin = const TypeChecker.fromRuntime(EquatableMixin);

  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = _ensureReadyForAutoequalClass(element);

    final generated = <String>[];

    final mixin = _generateMixinIfSpecified(classElement, annotation);
    if (mixin != null) {
      generated.add(mixin);
    }

    final extension = _generateExtension(classElement);
    generated.add(extension);

    return generated.join("\n\n");
  }

  ClassElement _ensureReadyForAutoequalClass(ClassElement element) {
    if (element is! ClassElement)
      throw '$element is not a ClassElement';

    if (element.isAbstract)
      throw '$element is abstract. Autoequal doesn\'t support abstract classes.';

    if (_isNotUseEquatable(element))
      throw '$element is not Equatable or EquatableMixin';

    return element;
  }

  String _generateMixinIfSpecified(ClassElement element, ConstantReader annotation) {
    final isGenerateMixin = annotation.read('generateMixin').boolValue;

    if (isGenerateMixin) {
      return _AutoequalMixinTemplate.print(
        name: element.name,
        onType: _isEquatable(element) ? "Equatable" : "EquatableMixin"
      );
    } else {
      return null;
    }
  }

  String _generateExtension(ClassElement element) {
    final className = element.name;

    final autoEqualFields = element.fields
        .where((field) => _isNotIgnoredField(field))
        .map((e) => e.name);

    return _AutoequalExtensionTemplate.print(
        name: className,
        props: autoEqualFields
    );
  }

  bool _isNotIgnoredField(FieldElement element) =>
      !(element.isStatic
          || element.name == "props"
          || _ignore.hasAnnotationOfExact(element)
          || _ignore.hasAnnotationOfExact(element.getter)
      );

  bool _isNotUseEquatable(ClassElement element) =>
      !(_isEquatable(element) || _isWithEquatableMixin(element));

  bool _isEquatable(ClassElement element) =>
      _equatable.isSuperOf(element);

  bool _isWithEquatableMixin(ClassElement element) =>
      element.mixins.any((type) => _equatableMixin.isExactly(type.element));
}

class _AutoequalMixinTemplate {
  static String print({
    String name,
    String onType
  }) =>
      """
      mixin _\$${name}AutoequalMixin on $onType {
        @override
        List<Object> get props =>
          _\$${name}Autoequal(this)._autoequalProps;
      }
      """;
}

class _AutoequalExtensionTemplate {
  static String print({
    String name,
    Iterable<String> props
  }) =>
      """
      extension _\$${name}Autoequal on $name {
        // ignore: unused_element
        List<Object> get _autoequalProps =>
            [${props.join(", ")}];
      }
      """;
}