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

      if (!canInclude) {
        return;
      }
    } else {
      for (final exclude in settings.exclude) {
        if (RegExp(exclude).hasMatch(element.name)) {
          return;
        }
      }
    }

    final annotation = autoequalChecker.firstAnnotationOfExact(element);

    final props = <FieldElement>[];

    ClassElement? clazz = element;
    var isSuper = false;

    do {
      if (clazz == null) {
        break;
      }

      props.addAll(clazz.fields
          .where((e) => _includeField(e, settings, isSuper: isSuper)));
      clazz = clazz.supertype?.element as ClassElement?;
      isSuper = true;
    } while (clazz != null);

    final equatableElement = EquatableElement(
      element: element,
      hasAnnotation: annotation != null,
      props: props,
      hasPropsField: element.getField('props') != null,
      isAutoInclude: settings.autoInclude,
    );

    if (equatableElement.shouldCreateExtension) {
      nodes.add(equatableElement);
    }
  }
}

bool _includeField(
  FieldElement element,
  Settings settings, {
  bool isSuper = false,
}) {
  if (element.isPrivate && isSuper) {
    return false;
  }

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
