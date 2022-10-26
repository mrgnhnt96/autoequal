part of generator;

class _AutoequalExtensionTemplate {
  static String extensionName(String name) => '_\$${name}Autoequal';

  static String generate(
    String className,
    Iterable<String> props, {
    bool includeDeprecated = true,
  }) {
    final extensionName = _AutoequalExtensionTemplate.extensionName(className);

    const deprecatedMessage = r"@Deprecated(r'Use _$props instead')";

    const deprecated = '''
        $deprecatedMessage
        List<Object?> get _autoequalProps => _\$props;''';

    return '''
      extension $extensionName on $className {
        ${includeDeprecated ? deprecated : ''}
        List<Object?> get _\$props => [${props.join(',')}];
      }
      ''';
  }
}
