import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'some_class.g.dart';

@autoequalMixin
class SomeClass with EquatableMixin, _$SomeClassAutoequalMixin {
  final String id;

  @ignoreAutoequal
  final String ignoredField;

  SomeClass({this.id, this.ignoredField,});
}