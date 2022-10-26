import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'getter.g.dart';

@autoequal
class Getter with EquatableMixin, _$GetterAutoequalMixin {
  const Getter();

  set one(String newValue) => print(newValue);
}
