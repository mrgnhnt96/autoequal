import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'getter.g.dart';

@autoequalMixin
class Getter extends Equatable with _$GetterAutoequalMixin {
  const Getter();

  set one(String newValue) => print(newValue);
}
