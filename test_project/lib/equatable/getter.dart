import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'getter.g.dart';

@autoequal
class Getter extends Equatable {
  const Getter();

  set one(String newValue) => print(newValue);

  @override
  List<Object?> get props => _$props;
}
