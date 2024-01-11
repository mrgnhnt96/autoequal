abstract interface class SettingsInterface {
  /// Whether to include getters in the props list.
  bool get includeGetters;

  /// Whether to automatically include all classes that extend Equatable
  /// or use EquatableMixin.
  bool get autoInclude;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// which classes to **not** generate the props list for.
  ///
  /// If [autoInclude] is false, this list will do nothing
  List<String> get exclude;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// which classes to generate the props list for.
  ///
  /// If [autoInclude] is true, this list will do nothing
  List<String> get include;
}
