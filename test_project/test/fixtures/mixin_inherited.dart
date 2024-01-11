// **************************************************************************
// AutoequalGenerator
// **************************************************************************

mixin _$BaseAutoequalMixin on Equatable {
  @override
  List<Object?> get props => _$BaseAutoequal((this as Base))._$props;
}
mixin _$InheritedAutoequalMixin on Equatable {
  @override
  List<Object?> get props => _$InheritedAutoequal((this as Inherited))._$props;
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
