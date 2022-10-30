import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'getter.g.dart';

@autoequal
class Getter with EquatableMixin, _$GetterAutoequalMixin {
  const Getter();

  String get one => 'one';
}
