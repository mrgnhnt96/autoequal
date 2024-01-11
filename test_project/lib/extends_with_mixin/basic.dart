import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'basic.g.dart';

@autoequalMixin
class Basic extends Equatable with _$BasicAutoequalMixin {
  const Basic(
    this.one, {
    required this.two,
    this.three,
  });

  final String one;
  final String two;
  final String? three;
}
