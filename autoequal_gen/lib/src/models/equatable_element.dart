import 'package:analyzer/dart/element/element.dart';
import 'package:autoequal_gen/src/element_extensions.dart';
import 'package:autoequal_gen/src/enums/equatable_type.dart';
import 'package:change_case/change_case.dart';

class EquatableElement {
  EquatableElement({
    required this.element,
    required this.hasAnnotation,
    required this.props,
    required bool hasPropsField,
    required this.isAutoInclude,
  }) : shouldCreateExtension =
            (isAutoInclude || hasAnnotation) && hasPropsField;

  final ClassElement element;
  final bool hasAnnotation;
  final List<FieldElement> props;
  final bool shouldCreateExtension;
  final bool isAutoInclude;

  String get name => element.name;

  String get sanitizedName => name.replaceAll(RegExp('^_+'), '').toPascalCase();

  EquatableType get type => element.equatableType;

  bool get hasPropsField => element.getField('props') != null;
}
