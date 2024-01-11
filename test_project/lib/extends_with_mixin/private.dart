import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'private.g.dart';

@autoequalMixin
class Private extends Equatable with _$PrivateAutoequalMixin {
  const Private(
    this._one, {
    required String two,
    String? three,
  })  : _two = two,
        _three = three;

  final String _one;
  final String _two;
  final String? _three;
}
