import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'include_getter.g.dart';

@autoequal
class IncludeGetter with EquatableMixin, _$IncludeGetterAutoequalMixin {
  const IncludeGetter();

  @include
  String get one => 'one';
}
