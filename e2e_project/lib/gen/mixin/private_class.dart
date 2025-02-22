import 'package:equatable/equatable.dart';

part 'private_class.g.dart';

class _PrivateClass with EquatableMixin {
  const _PrivateClass(
    this.one, {
    required this.two,
    this.three,
  });

  final String one;
  final String two;
  final String? three;

  @override
  List<Object?> get props => _$props;
}
