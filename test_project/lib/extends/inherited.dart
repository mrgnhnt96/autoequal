import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'inherited.g.dart';

@autoequal
class Base extends Equatable {
  const Base(this.one);

  final String one;

  @override
  List<Object?> get props => _$props;
}

@autoequal
class Inherited extends Base {
  const Inherited(super.one, this.two);

  final String two;

  @override
  List<Object?> get props => [...super.props, _$props];
}
