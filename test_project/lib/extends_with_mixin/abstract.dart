import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'abstract.g.dart';

@autoequalMixin
abstract class Abstract extends Equatable with _$AbstractAutoequalMixin {
  const Abstract(this.one);

  final String one;
}
