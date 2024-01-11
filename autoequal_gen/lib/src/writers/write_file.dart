import 'package:autoequal_gen/src/models/equatable_element.dart';
import 'package:autoequal_gen/src/writers/write_extension.dart';
import 'package:code_builder/code_builder.dart';

List<Spec> writeFile(List<EquatableElement> equatables) {
  final extensions = equatables.map(writeExtension);

  return [
    ...extensions,
  ];
}
