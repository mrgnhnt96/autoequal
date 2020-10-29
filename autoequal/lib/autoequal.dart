library autoequal;

const Autoequal autoequal = Autoequal();

const Autoequal autoequalMixin = Autoequal(generateMixin: true);

const IgnoreAutoequal ignoreAutoequal = IgnoreAutoequal();

/// For class marked with this annotation will be generated properties list List<Object>
/// to use it as value for List<Object> props of Equatable object.
/// If generateMixin=true so a mixin with overrides 'List<Object> get props' will be additionally generated.
class Autoequal {
  final bool generateMixin;

  const Autoequal({this.generateMixin = false});
}

/// Field marked with this annotation will be ignored
class IgnoreAutoequal {
  const IgnoreAutoequal();
}