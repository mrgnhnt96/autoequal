part of 'generator.dart';

extension on EquatableType {
  bool get isClass => this == EquatableType.class_;

  bool get isMixin => this == EquatableType.mixin;

  bool get isNone => this == EquatableType.none;

  String? get equatableName {
    switch (this) {
      case EquatableType.class_:
        return 'Equatable';
      case EquatableType.mixin:
        return 'EquatableMixin';
      case EquatableType.none:
        return null;
    }
  }
}

extension on ClassElement {
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

extension on Element {
  bool get isWithEquatableMixin {
    final Element element = this;

    if (element is! ClassElement) {
      return false;
    }

    if (element.mixins.isEmpty) {
      return false;
    }

    return element.mixins.any(
      (InterfaceType type) => _equatableMixin.isExactly(type.element),
    );
  }

  EquatableType get equatableType {
    if (this is! ClassElement) {
      return EquatableType.none;
    }

    if (_equatable.isSuperOf(this)) {
      return EquatableType.class_;
    } else if (isWithEquatableMixin) {
      return EquatableType.mixin;
    } else {
      return EquatableType.none;
    }
  }
}
