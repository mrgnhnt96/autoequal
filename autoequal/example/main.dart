import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'main.g.dart';

@autoequal
class ExampleClass extends Equatable {
  const ExampleClass({
    required this.value,
    this.ignored,
    this.optional,
  });

  final String? optional;
  final String value;

  @ignore
  final String? ignored;
}
