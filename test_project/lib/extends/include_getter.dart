import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'include_getter.g.dart';

@autoequal
class IncludeGetter extends Equatable {
  const IncludeGetter();

  @includeAutoequal
  String get one => 'one';

  @override
  List<Object?> get props => _$props;
}
