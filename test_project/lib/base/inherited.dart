import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'inherited.g.dart';

@autoequal
class Base {REPLACE} {
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
  List<Object?> get props => _$props;
}
