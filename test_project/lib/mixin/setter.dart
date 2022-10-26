import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'setter.g.dart';

@autoequal
class Setter with EquatableMixin, _$SetterAutoequalMixin {
  const Setter();

  set one(String newValue) => print(newValue);
}
