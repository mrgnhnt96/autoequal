import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:autoequal_gen/gen/settings.dart';
import 'package:autoequal_gen/src/checkers/checkers.dart';
import 'package:autoequal_gen/src/element_extensions.dart';
import 'package:autoequal_gen/src/models/equatable_element.dart';

class ClassVisitor extends RecursiveElementVisitor<void> {
  ClassVisitor(this.settings);

  final Settings settings;
  final List<EquatableElement> nodes = [];

  @override
  void visitClassElement(ClassElement element) {
    if (!element.usesEquatable) {
      return;
    }

    if (!settings.autoInclude) {
      bool canInclude = true;

      for (final exclude in settings.include) {
        if (RegExp(exclude).hasMatch(element.name)) {
          canInclude = true;
          break;
        }
      }

      if (!canInclude && includeChecker.hasAnnotationOfExact(element)) {
        canInclude = true;
      }

      if (canInclude) {
        return;
      }
    } else {
      for (final exclude in settings.exclude) {
        if (RegExp(exclude).hasMatch(element.name)) {
          return;
        }
      }
    }

    final isMixin = _isMixin(element);

    final equatableElement = EquatableElement(
      element: element,
      hasMixinAnnotation: isMixin,
      props: element.fields.where((e) => _includeField(e, settings)).toList(),
    );

    nodes.add(equatableElement);
  }
}

bool _isMixin(ClassElement node) {
  final annotation = autoequalChecker.firstAnnotationOfExact(node);

  if (annotation == null) {
    return false;
  }

  return annotation.getField('mixin')?.toBoolValue() ?? false;
}

bool _includeField(FieldElement element, Settings settings) {
  if (element.isStatic) {
    return false;
  }

  if (element.name == 'props') {
    return false;
  }

  if (ignoreChecker.hasAnnotationOfExact(element)) {
    return false;
  }

  if (element.getter == null) {
    return false;
  }

  if (includeChecker.hasAnnotationOfExact(element)) {
    return true;
  }

  if (ignoreChecker.hasAnnotationOfExact(element.getter!)) {
    return false;
  }

  if (includeChecker.hasAnnotationOfExact(element.getter!)) {
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
