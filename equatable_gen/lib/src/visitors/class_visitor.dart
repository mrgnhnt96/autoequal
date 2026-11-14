import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor2.dart';
import 'package:equatable_gen/gen/settings.dart';
import 'package:equatable_gen/src/checkers/checkers.dart';
import 'package:equatable_gen/src/element_extensions.dart';
import 'package:equatable_gen/src/models/equatable_element.dart';

class ClassVisitor extends RecursiveElementVisitor2<void> {
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
        if (element.name case final String name
            when RegExp(exclude).hasMatch(name)) {
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
        if (element.name case final String name
            when RegExp(exclude).hasMatch(name)) {
          return;
        }
      }
    }

    final annotation = generatePropsChecker.firstAnnotationOfExact(element);

    final props = <FieldElement>[];

    ClassElement? clazz = element;
    var isSuper = false;

    do {
      if (clazz == null) {
        break;
      }

      props.addAll(
        clazz.fields.where(
          (e) => _includeField(e, settings, element, isSuper: isSuper),
        ),
      );
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

/// When walking superclasses, [field] may be declared on a superclass while the
/// subclass overrides it with a getter (e.g. `final path` → `@ignore String get path`).
/// Metadata on the override lives on the subclass getter, so we resolve it via
/// [subjectClass] instead of only using [field.getter].
GetterElement? _getterForEquatableProps(
  FieldElement field,
  ClassElement subjectClass, {
  required bool isSuper,
}) {
  final inheritedGetter = field.getter;
  if (!isSuper) {
    return inheritedGetter;
  }
  final name = field.name;
  if (name == null) {
    return inheritedGetter;
  }
  final shadowing = subjectClass.getGetter(name);
  if (shadowing == null) {
    return inheritedGetter;
  }
  if (shadowing.enclosingElement != field.enclosingElement) {
    return shadowing;
  }
  return inheritedGetter;
}

bool _includeField(
  FieldElement element,
  Settings settings,
  ClassElement subjectClass, {
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

  final getterForMetadata = _getterForEquatableProps(
    element,
    subjectClass,
    isSuper: isSuper,
  );

  if (ignoreChecker.hasAnnotationOfExact(element)) {
    return false;
  }

  if (getterForMetadata != null &&
      ignoreChecker.hasAnnotationOfExact(getterForMetadata)) {
    return false;
  }

  if (getterForMetadata == null) {
    return false;
  }

  if (includeChecker.hasAnnotationOfExact(element) ||
      includeChecker.hasAnnotationOfExact(getterForMetadata)) {
    return true;
  }

  if (element.isOriginGetterSetter) {
    if (settings.includeGetters) {
      return true;
    }

    return false;
  }

  return true;
}
