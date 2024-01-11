import 'package:equatable/equatable.dart';

class Example extends Equatable {
  const Example({
    required this.name,
    required this.age,
  });

  final String name;
  final int age;

  @override
  List<Object?> get props => _$props;
}
