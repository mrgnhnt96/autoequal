import 'package:autoequal/autoequal.dart';
import 'package:autoequal_gen/src/checkers/type_checker.dart';

const TypeChecker equatableChecker =
    TypeChecker.fromName('Equatable', packageName: 'equatable');
const TypeChecker equatableMixinChecker =
    TypeChecker.fromName('EquatableMixin', packageName: 'equatable');
final TypeChecker ignoreChecker = TypeChecker.fromName('$IgnoreAutoequal');
final TypeChecker includeChecker = TypeChecker.fromName('$IncludeAutoequal');
final TypeChecker autoequalChecker = TypeChecker.fromName('$Autoequal');
