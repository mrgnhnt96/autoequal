part of generator;

class _AutoequalExtensionTemplate {
  static String extensionName(String name) => '_\$${name}Autoequal';

  static String generate(String className, Iterable<String> props) {
    final extensionName = _AutoequalExtensionTemplate.extensionName(className);

    return '''
      extension $extensionName on $className {
        List<Object> get _autoequalProps =>[${props.join(', ')}];
      }
      ''';
  }
}
