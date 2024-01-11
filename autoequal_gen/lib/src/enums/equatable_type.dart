/// The type of [Equatable] inheritance.
enum EquatableType {
  class_,
  mixin,
  none,
}

/// The extension for [EquatableType] to check annotated elements'
/// autoequal types.
extension EquatableTypeX on EquatableType {
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
