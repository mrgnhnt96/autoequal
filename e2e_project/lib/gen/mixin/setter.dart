import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'setter.g.dart';

@autoequal
class Setter with EquatableMixin {
  const Setter();

  set one(String newValue) => print(newValue);

  @override
  List<Object?> get props => _$props;
}
