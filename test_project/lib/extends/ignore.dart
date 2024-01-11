import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'ignore.g.dart';

@autoequal
class Ignore extends Equatable {
  const Ignore(
    this.one, {
    required this.two,
    this.three,
  });

  @ignoreAutoequal
  final String one;
  final String two;
  final String? three;

  @override
  List<Object?> get props => _$props;
}
