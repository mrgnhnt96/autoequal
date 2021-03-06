import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'main.g.dart';

@autoequalMixin
class ExampleClass extends Equatable with _$ExampleClassAutoequalMixin {
  final String value;
  final String? optional;

  @ignoreAutoequal
  final String? ignored;

  ExampleClass({
    required this.value,
    this.ignored,
    this.optional,
  });
}
