import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'main.g.dart';

@autoequal
class Example1Class extends Equatable {
  Example1Class({
    required this.value,
    this.ignored,
    this.optional,
  });

  final String value;
  final String? optional;

  @ignore
  final String? ignored;

  @override
  List<Object?> get props => _$props;
}

@autoequal
class Example2Class with EquatableMixin {
  const Example2Class({
    required this.value,
    this.ignored,
    this.optional,
  });

  final String value;
  final String? optional;

  @ignore
  final String? ignored;

  @override
  List<Object?> get props => _$props;
}
