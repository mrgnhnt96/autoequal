part of generator;

class _AutoequalMixinTemplate {
  static String mixinName(String className) => '_\$${className}AutoequalMixin';

  static String generate(
    String className,
    String onTypeName, {
    required bool generateSuperProps,
  }) {
    final mixinName = _AutoequalMixinTemplate.mixinName(className);
    final extensionName = _AutoequalExtensionTemplate.extensionName(className);

    final superProps = generateSuperProps ? '...super.props,' : '';

    final open = generateSuperProps ? '[' : '';
    final close = generateSuperProps ? ']' : '';
    final spreadOp = generateSuperProps ? '...' : '';

    return '''
      mixin $mixinName on $onTypeName {
        @override
        List<Object?> get props =>
          $open$superProps$spreadOp$extensionName(this as $className)._\$props$close;
      }
      ''';
  }
}
