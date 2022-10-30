import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'include_getter.g.dart';

@autoequal
class IncludeGetter with EquatableMixin, _$IncludeGetterAutoequalMixin {
  const IncludeGetter();

  @includeAutoequal
  String get one => 'one';
}
