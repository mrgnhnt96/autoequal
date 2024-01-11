import 'package:autoequal/autoequal.dart';
import 'package:autoequal_gen/src/checkers/type_checker.dart';

const TypeChecker equatableChecker =
    TypeChecker.fromName('Equatable', packageName: 'Equatable');
const TypeChecker equatableMixinChecker =
    TypeChecker.fromName('EquatableMixin', packageName: 'Equatable');
final TypeChecker ignoreChecker = TypeChecker.fromName('$IgnoreAutoequal');
final TypeChecker includeChecker = TypeChecker.fromName('$IncludeAutoequal');
final TypeChecker autoequalChecker = TypeChecker.fromName('$Autoequal');
