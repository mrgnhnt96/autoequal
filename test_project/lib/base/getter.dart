import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'getter.g.dart';

@autoequal
class Getter {REPLACE} {
  const Getter();

  String get one => 'one';

  @override
  List<Object?> get props => _$props;
}
