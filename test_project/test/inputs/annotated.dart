import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'abstract.g.dart';

@autoequal
abstract class Abstract extends Equatable {
  const Abstract(this.one);

  final String one;

  @override
  List<Object?> get props => _$props;
}
