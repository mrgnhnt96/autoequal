import 'package:equatable/equatable.dart';
import 'package:equatable_annotations/equatable_annotations.dart';

abstract class BaseRecord extends Equatable {
  const BaseRecord(this.createdAt, this._secret);

  final int createdAt;
  // ignore: unused_field
  final int _secret;
}

@generateProps
class Sample extends BaseRecord {
  const Sample(this.name, this.enabled, int createdAt) : super(createdAt, 7);

  final String name;

  @ignore
  final bool enabled;

  static const String category = 'sample';

  String get derived => name.toUpperCase();

  @include
  int get included => name.length;

  @override
  List<Object?> get props => _$props;
}
