import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'getter.g.dart';

@autoequalMixin
class Getter extends Equatable with _$GetterAutoequalMixin {
  const Getter();

  String get one => 'one';
}
