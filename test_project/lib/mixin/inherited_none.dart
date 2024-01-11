import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'inherited_none.g.dart';

class Base {
  const Base(this.one);

  final String one;
}

@autoequal
class InheritedNone extends Base
    with EquatableMixin, _$InheritedNoneAutoequalMixin {
  const InheritedNone(super.one, this.two);

  final String two;
}
