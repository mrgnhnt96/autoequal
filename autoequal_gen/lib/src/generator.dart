library generator;

import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

import 'package:autoequal/autoequal.dart';

part 'template/extension.dart';
part 'template/mixin.dart';

/// For class marked with @Autoequal annotation will be generated properties list List<Object>
/// to use it as value for List<Object> props of Equatable object.
/// If mixin=true so a mixin with overrides 'List<Object> get props' will be additionally generated.
class AutoequalGenerator extends GeneratorForAnnotation<Autoequal> {
  final _ignore = const TypeChecker.fromRuntime(IgnoreAutoequal);
  final _equatable = const TypeChecker.fromRuntime(Equatable);
  final _equatableMixin = const TypeChecker.fromRuntime(EquatableMixin);

  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = _ensureReadyForAutoequalClass(element);

    final generated = <String>[];

    final mixin = _generateMixinIfSpecified(classElement, annotation);
    if (mixin != null) {
      generated.add(mixin);
    }

    final extension = _generateExtension(classElement);
    if (extension != null) {
      generated.add(extension);
    }

    return generated.join('\n\n');
  }

  ClassElement _ensureReadyForAutoequalClass(Element element) {
    if (element is! ClassElement) throw '$element is not a ClassElement';

    final classElement = element as ClassElement;

    if (classElement.isAbstract) {
      throw "$element is abstract. Autoequal doesn't support abstract classes.";
    }

    if (_isNotUseEquatable(classElement)) {
      throw '$element is not Equatable or EquatableMixin';
    }

    return classElement;
  }

  String _generateMixinIfSpecified(
      ClassElement classElement, ConstantReader annotation) {
    final isMixin = annotation.read('mixin').boolValue;

    if (isMixin) {
      final onTypeName =
          _isEquatable(classElement) ? 'Equatable' : 'EquatableMixin';
      return _AutoequalMixinTemplate.generate(classElement.name, onTypeName);
    } else {
      return null;
    }
  }

  String _generateExtension(ClassElement classElement) {
    final name = classElement.name;

    final autoEqualFields = classElement.fields
        .where((field) => _isNotIgnoredField(field))
        .map((e) => e.name);

    return _AutoequalExtensionTemplate.generate(name, autoEqualFields);
  }

  bool _isNotIgnoredField(FieldElement element) => !(element.isStatic ||
      element.name == 'props' ||
      _ignore.hasAnnotationOfExact(element) ||
      _ignore.hasAnnotationOfExact(element.getter));

  bool _isNotUseEquatable(ClassElement element) =>
      !(_isEquatable(element) || _isWithEquatableMixin(element));

  bool _isEquatable(ClassElement element) => _equatable.isSuperOf(element);

  bool _isWithEquatableMixin(ClassElement element) =>
      element.mixins.any((type) => _equatableMixin.isExactly(type.element));
}
