import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'abstract.g.dart';

@autoequal
abstract class Abstract with EquatableMixin, _$AbstractAutoequalMixin {
  const Abstract(this.one);

  final String one;
}
