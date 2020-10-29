library autoequal;

const Autoequal autoequal = Autoequal();

const IgnoreAutoequal ignoreAutoequal = IgnoreAutoequal();

/// For class marked with this annotation will be generated properties list List<Object>
/// to use it as value for List<Object> props of Equatable object.
class Autoequal {
  const Autoequal();
}

/// Field marked with this annotation will be ignored
class IgnoreAutoequal {
  const IgnoreAutoequal();
}