part of '../generator.dart';

final class _AutoequalMixinTemplate {
  static String mixinName(String className) => '_\$${className}AutoequalMixin';

  static String generate(
    String className,
    String onTypeName, {
    required bool generateSuperProps,
  }) {
    final String mixinName = _AutoequalMixinTemplate.mixinName(className);
    final String extensionName =
        _AutoequalExtensionTemplate.extensionName(className);

    final String superProps = generateSuperProps ? '...super.props,' : '';

    final String open = generateSuperProps ? '[' : '';
    final String close = generateSuperProps ? ']' : '';
    final String spreadOp = generateSuperProps ? '...' : '';

    return '''
      mixin $mixinName on $onTypeName {
        @override
        List<Object?> get props =>
          $open$superProps$spreadOp$extensionName(this as $className)._\$props$close;
      }
      ''';
  }
}
