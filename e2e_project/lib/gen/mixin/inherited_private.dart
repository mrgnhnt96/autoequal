import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'inherited_private.g.dart';

@autoequal
class Base with EquatableMixin {
  const Base(this._one);

  final String _one;

  @override
  List<Object?> get props => _$props;
}

class InheritedPrivate extends Base {
  const InheritedPrivate(super._one, this._two);

  final String _two;

  @override
  List<Object?> get props => _$props;
}
