[![Pub Package](https://img.shields.io/pub/v/autoequal.svg)](https://pub.dev/packages/autoequal)

Provides [Dart Build System](https://pub.dev/packages/build) builder for generating `List<Object?> _autoequalProps` private extensions for classes annotated with [autoequal](https://pub.dev/packages/autoequal).

## Usage

#### In your `pubspec.yaml` file:
- Add to `dependencies` section `autoequal: ^0.4.0`
- Add to `dev_dependencies` section `autoequal_gen: ^0.4.0`
- Add to `dev_dependencies` section `build_runner: ^2.2.0`
- Set `environment` to at least Dart 2.17.0 version like so: `">=2.17.0 <3.0.0"`

Your `pubspec.yaml` should look like so:

```yaml
name: project_name
description: project description
version: 1.0.0

environment:
  sdk: ">=2.17.0 <3.0.0"

dependencies:
  #...
  autoequal: ^0.4.0
  
dev_dependencies:
  #...
  build_runner: ^2.2.0
  autoequal_gen: ^0.4.0
```

#### Annotate your class with `@autoequal` annotation:

```dart
import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'some_class.g.dart';

@autoequal
class SomeClass extends Equatable {
  final String id;

  SomeClass({this.id, this.random});

  @override
  List<Object?> get props => _autoequalProps; //_autoequalProps will be generated
}
```

Make sure that you set the part file as in the example above `part 'your_file_name.g.dart';`.

#### Launch code generation:

```
flutter pub run build_runner build
```

#### The extension will be generated:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'some_class.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$SomeClassAutoequal on SomeClass {
  List<Object> get _autoequalProps => [id];
}

```

## Additional features

#### Autoequal mixin

The `@autoequalMixin` or `@Autoequal(mixin: true)` will additionally generate a mixin class.
```dart
mixin _$SomeClassAutoequalMixin on Equatable {
  @override
  List<Object?> get props => _$SomeClassAutoequal(this)._autoequalProps;
}
```

To use it just add it to your class:
```dart
@autoequalMixin
class SomeClass extends Equatable with _$SomeClassAutoequalMixin {
  final String id;

  SomeClass({this.id});
}
```

#### Ignore field

The `autoequal` will exclude any field annotated with `@ignoreAutoequal`.
```dart
@ignoreAutoequal
final int random;
```

