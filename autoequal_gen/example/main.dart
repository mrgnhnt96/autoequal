import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'main.g.dart';

@autoequalMixin
class ExampleClass with EquatableMixin, _$ExampleClassAutoequalMixin {
  final String id;

  @ignoreAutoequal
  final String ignoredField;

  ExampleClass({this.id, this.ignoredField,});
}