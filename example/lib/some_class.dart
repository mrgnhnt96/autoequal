import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'some_class.g.dart';

@autoequal
class SomeClass extends Equatable {
  final String id;

  @ignoreAutoequal
  String get additionalField => "additionalField";

  SomeClass({this.id});

  @override
  List<Object> get props => _autoequalProps;
}