import 'package:autoequal_gen/src/enums/equatable_type.dart';
import 'package:autoequal_gen/src/models/equatable_element.dart';
import 'package:code_builder/code_builder.dart';

Mixin writeMixin(EquatableElement element) {
  return Mixin(
    (b) => b
      ..name = '_\$${element.name}AutoequalMixin'
      ..on = TypeReference(
        (b) => b.symbol = element.type.equatableName,
      )
      ..methods.add(
        Method(
          (b) => b
            ..annotations.add(refer('override'))
            ..returns = refer('List<Object?>')
            ..type = MethodType.getter
            ..name = 'props'
            ..body = _writeProps(element),
        ),
      ),
  );
}

Code _writeProps(EquatableElement element) {
  return refer('_\$${element.name}Autoequal')
      .type
      .newInstance(
        [
          refer('this').asA(
            refer(element.name),
          ),
        ],
      )
      .property('_\$props')
      .code;
}
