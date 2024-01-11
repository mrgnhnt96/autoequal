import 'package:json_annotation/json_annotation.dart';

import 'settings_interface.dart';

part 'settings.g.dart';

@JsonSerializable(constructor: 'defaults')
class Settings implements SettingsInterface {
  const Settings({
    required this.includeGetters,
    required this.autoInclude,
    required this.exclude,
    required this.include,
  });

  Settings.defaults({
    this.includeGetters = false,
    this.autoInclude = false,
    this.exclude = const [],
    this.include = const [],
  });

  factory Settings.fromJson(Map json) {
    final settings = _$SettingsFromJson(json);

    final patterns = <String, List<String>>{};

    settings.exclude
        .forEach((e) => patterns.putIfAbsent(e, () => []).add('exclude'));
    settings.include
        .forEach((e) => patterns.putIfAbsent(e, () => []).add('include'));

    // make sure that the priorities patterns are valid regex
    for (final MapEntry(key: pattern, value: locations) in patterns.entries) {
      try {
        RegExp(pattern);
      } catch (error) {
        throw ArgumentError.value(
          pattern,
          'Found in ${locations.join(',')}',
          error,
        );
      }
    }
    return settings;
  }
  @override
  final bool autoInclude;

  @override
  final List<String> exclude;

  @override
  final List<String> include;

  @override
  final bool includeGetters;
}
