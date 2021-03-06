import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'some_class.g.dart';

@autoequal
class SomeClass extends Equatable {
  final String value;
  final String? optional;

  @ignoreAutoequal
  final String? ignored;

  SomeClass({
    required this.value,
    this.ignored,
    this.optional,
  });

  @override
  List<Object?> get props => _autoequalProps;
}

@autoequalMixin
class SomeClassMix with EquatableMixin, _$SomeClassMixAutoequalMixin {
  final String value;
  final String? optional;

  @ignoreAutoequal
  final String? ignored;

  SomeClassMix({
    required this.value,
    this.ignored,
    this.optional,
  });
}
