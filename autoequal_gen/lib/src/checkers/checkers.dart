import 'package:autoequal/autoequal.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;

const TypeChecker equatableChecker = TypeChecker.typeNamedLiterally(
  'Equatable',
  inPackage: 'equatable',
);
const TypeChecker equatableMixinChecker = TypeChecker.typeNamedLiterally(
  'EquatableMixin',
  inPackage: 'equatable',
);
const TypeChecker ignoreChecker = TypeChecker.typeNamed(
  IgnoreAutoequal,
  inPackage: 'autoequal',
);
const TypeChecker includeChecker = TypeChecker.typeNamed(
  IncludeAutoequal,
  inPackage: 'autoequal',
);
const TypeChecker autoequalChecker = TypeChecker.typeNamed(
  Autoequal,
  inPackage: 'autoequal',
);
