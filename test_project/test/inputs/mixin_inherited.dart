import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'inherited.g.dart';

@autoequalMixin
class Base extends Equatable with _$BaseAutoequalMixin {
  const Base(this.one);

  final String one;
}

@autoequalMixin
class Inherited extends Base with _$InheritedAutoequalMixin {
  const Inherited(super.one, this.two);

  final String two;
}
