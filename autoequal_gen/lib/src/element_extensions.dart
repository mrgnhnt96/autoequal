import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:autoequal_gen/src/checkers/checkers.dart';
import 'package:autoequal_gen/src/enums/equatable_type.dart';

/// The extension for [ClassElement] to check if the annotated
/// elements' inheritances are [Equatable].
extension ClassElementX on ClassElement {
  bool get usesEquatable =>
      equatableChecker.isSuperOf(this) ||
      usesEquatableViaMixin ||
      equatableIsSuper;

  bool get equatableIsSuper => equatableChecker.isSuperOf(this);

  bool get superHasProps {
    final ignore = {
      'Object',
      'Equatable',
      'EquatableMixin',
    };

    for (final InterfaceType superType in allSupertypes) {
      final element = superType.element;
      if (ignore.contains(element.name)) {
        continue;
      }

      if (element is! ClassElement) {
        continue;
      }

      if (element.usesEquatable) {
        return true;
      }

      // final propsField = element.getGetter('props');

      // if (propsField != null) {
      //   return true;
      // }

      // // check the source if the getter is not found
      // final source = element.source.contents.data;
      // if (source.contains('List<Object?> get props ')) {
      //   return true;
      // }
    }

    return false;
  }
}

extension ElementX on Element {
  bool get usesEquatableViaMixin {
    final Element element = this;

    if (element is! ClassElement) {
      return false;
    }

    final mixins = {...element.mixins};

    var theSuper = element.supertype;
    do {
      if (theSuper == null) {
        break;
      }

      mixins.addAll(theSuper.mixins);
      theSuper = theSuper.superclass;
    } while (theSuper != null);

    if (mixins.isEmpty) {
      return false;
    }

    return mixins.any(
      (InterfaceType type) => equatableMixinChecker.isExactly(type.element),
    );
  }

  bool get hasDirectEquatableMixin {
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
    } else if (hasDirectEquatableMixin) {
      return EquatableType.mixin;
    } else {
      return EquatableType.none;
    }
  }
}
