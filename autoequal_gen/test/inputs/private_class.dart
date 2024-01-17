import 'package:equatable/equatable.dart';

class _Data extends Equatable {
  const _Data(this.one);

  final int one;

  @override
  List<Object?> get props => _$props;
}
