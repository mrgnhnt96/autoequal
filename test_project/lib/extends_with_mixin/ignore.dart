import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'ignore.g.dart';

@autoequalMixin
class Ignore extends Equatable with _$IgnoreAutoequalMixin {
  const Ignore(
    this.one, {
    required this.two,
    this.three,
  });

  @ignore
  final String one;
  final String two;
  final String? three;
}
