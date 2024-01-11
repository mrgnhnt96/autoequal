// **************************************************************************
// AutoequalGenerator
// **************************************************************************

mixin _$BaseAutoequalMixin on EquatableMixin {
  @override
  List<Object?> get props => _$BaseAutoequal((this as Base))._$props;
}

extension _$BaseAutoequal on Base {
  List<Object?> get _$props => [one];
}

extension _$InheritedAutoequal on Inherited {
  List<Object?> get _$props => [
        two,
        ...(this as Base)._$props,
      ];
}
