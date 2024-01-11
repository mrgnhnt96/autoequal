import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:autoequal_gen/src/checkers/checkers.dart';
import 'package:autoequal_gen/src/enums/equatable_type.dart';

/// The extension for [ClassElement] to check if the annotated
/// elements' inheritances are [Equatable].
extension ClassElementX on ClassElement {
  bool get usesEquatable => !equatableType.isNone;

  bool get equatableIsSuper {
    for (final InterfaceType superType in allSupertypes) {
      final InterfaceElement element = superType.element;

      final String name = element.name;
      if (name == 'Equatable' ||
          name == 'EquatableMixin' ||
          name.endsWith('AutoequalMixin') ||
          name == 'Object') {
        continue;
      }

      if (!element.equatableType.isNone) {
        return true;
      }
    }

    return false;
  }

  bool get superHasProps {
    for (final InterfaceType superType in allSupertypes) {
      final InterfaceElement element = superType.element;

      if (element.getGetter('props') != null) {
        return true;
      }
    }

    return false;
  }
}

extension ElementX on Element {
  bool get isWithEquatableMixin {
    final Element element = this;

    if (element is! ClassElement) {
      return false;
    }

    if (element.mixins.isEmpty) {
      return false;
    }

    return element.mixins.any(
      (InterfaceType type) => equatableMixinChecker.isExactly(type.element),
    );
  }

  EquatableType get equatableType {
    if (this is! ClassElement) {
      return EquatableType.none;
    }

    if (equatableChecker.isSuperOf(this)) {
      return EquatableType.class_;
    } else if (isWithEquatableMixin) {
      return EquatableType.mixin;
    } else {
      return EquatableType.none;
    }
  }
}
