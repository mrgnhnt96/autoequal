final class Settings {
  const Settings({
    required this.includeGetters,
  });

  factory Settings.fromConfig(Map json) {
    return Settings(
      includeGetters: json['include_getters'] as bool? ?? false,
    );
  }

  final bool includeGetters;
}
