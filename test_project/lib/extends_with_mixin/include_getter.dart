import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'include_getter.g.dart';

@autoequalMixin
class IncludeGetter extends Equatable with _$IncludeGetterAutoequalMixin {
  const IncludeGetter();

  @include
  String get one => 'one';
}
