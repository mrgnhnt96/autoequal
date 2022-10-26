part of generator;

class _AutoequalMixinTemplate {
  static String mixinName(String className) => '_\$${className}AutoequalMixin';

  static String generate(String className, String onTypeName) {
    final mixinName = _AutoequalMixinTemplate.mixinName(className);
    final extensionName = _AutoequalExtensionTemplate.extensionName(className);

    return '''
      mixin $mixinName on $onTypeName {
        @override
        List<Object?> get props =>
          $extensionName(this as $className)._\$props;
      }
      ''';
  }
}
