import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'static.g.dart';

@autoequal
class Static extends Equatable {
  const Static(
    this.one, {
    required this.two,
    this.three,
  });

  final String one;
  final String two;
  final String? three;

  static const String staticField = 'staticField';

  @override
  List<Object?> get props => _$props;
}
