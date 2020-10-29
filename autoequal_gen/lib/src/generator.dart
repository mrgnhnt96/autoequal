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
    final classElement = _ensureAutoequalClass(element);

    final className = classElement.name;

    final autoEqualFields = classElement.fields
        .where((field) => _isNotIgnoredField(field))
        .map((e) => e.name);

    return _AutoequalExtensionTemplate.print(className, autoEqualFields);
  }

  ClassElement _ensureAutoequalClass(ClassElement element) {
    if (element is! ClassElement)
      throw '$element is not a ClassElement';

    if (element.isAbstract)
      throw '$element is abstract. Autoequal doesn\'t support abstract classes.';

    if (_isNotEquatable(element))
      throw '$element is not Equatable or EquatableMixin';

    return element;
  }

  bool _isNotIgnoredField(FieldElement element) =>
      !(element.isStatic
          || element.name == "props"
          || _ignore.hasAnnotationOfExact(element)
          || _ignore.hasAnnotationOfExact(element.getter)
      );

  bool _isNotEquatable(ClassElement element) =>
      !(_equatable.isSuperOf(element) || _equatableMixin.isSuperOf(element));
}

class _AutoequalExtensionTemplate {
  static String print(String className, Iterable<String> autoEqualFields) =>
      """
      extension ${className}Autoequal on $className {
        List<Object> get _autoequalProps =>
            [${autoEqualFields.join(", ")}];
      }
      """;
}