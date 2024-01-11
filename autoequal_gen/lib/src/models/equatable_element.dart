import 'package:analyzer/dart/element/element.dart';
import 'package:autoequal_gen/src/element_extensions.dart';
import 'package:autoequal_gen/src/enums/equatable_type.dart';
import 'package:change_case/change_case.dart';

class EquatableElement {
  const EquatableElement({
    required this.element,
    required this.hasMixinAnnotation,
    required this.props,
  });

  final ClassElement element;
  final bool hasMixinAnnotation;
  final List<FieldElement> props;

  String get name => element.name;

  String get sanitizedName => name.replaceAll(RegExp('^_+'), '').toPascalCase();

  EquatableType get type => element.equatableType;

  bool get hasPropsField => element.getField('props') != null;

  bool get shouldGenerateMixin => type.isMixin || hasMixinAnnotation;

  bool get generateSuperProps =>
      (element.equatableIsSuper || element.usesEquatableViaMixin) &&
      element.superHasProps;
}
