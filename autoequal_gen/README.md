[![Pub Package](https://img.shields.io/pub/v/autoequal.svg)](https://pub.dev/packages/autoequal)

Provides [Dart Build System](https://pub.dev/packages/build) builder for generating `List<Object?> _$props` private extensions for classes annotated with [autoequal](https://pub.dev/packages/autoequal).

## Usage

### In your `pubspec.yaml` file

- Add `autoequal` to your `dependencies`
- Add `autoequal_gen` to your `dev_dependencies`
- Add `build_runner` to your `dev_dependencies`

### Annotate your class with `@autoequal` annotation

```dart
import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'some_class.g.dart';

@autoequal
class SomeClass extends Equatable {
  const SomeClass({this.id, this.random});

  final String id;

  @override
  List<Object?> get props => _$props; //_$props will be generated
}
```

Make sure that you set the part file as in the example above `part 'your_file_name.g.dart';`.

#### Launch code generation

```bash
flutter pub run build_runner build
```

#### The extension will be generated

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'some_class.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$SomeClassAutoequal on SomeClass {
  List<Object> get _$props => [id];
}

```

### Auto Include with Annotating

The `@autoequal` is smart enough to generate the `props` getter for classes that use `Equatable` without having to annotate the class with `@autoequal`.

To do this, update your `build.yaml` file to:

Include the `auto_include: true` option

  ```yaml
  targets:
    $default:
      builders:
        autoequal_gen:
          enabled: true
          options:
            auto_include: true
            exclude:
              - SomeClass # regex pattern (for class names)
  ```

Or, add a regex pattern to the `include` option

  ```yaml
  targets:
    $default:
      builders:
        autoequal_gen:
          enabled: true
          options:
            include:
              - SomeClass # regex pattern (for class names)
  ```

Then, use equatable and create the `props` getter as you normally would.

  ```dart
  class SomeClass with EquatableMixin { // or `extends Equatable`
    const SomeClass({this.id});

    final String id;

    @override
    List<Object?> get props => _$props;
  }
  ```

  _NOTE:_ If the props getter is not defined, the autoequal will not generate the `_$props` variable.

## Inheritance

If your class extends another class that uses Equatable, you can use the `@autoequal` annotation and autoequal will do the rest!

```dart
@autoequal
class SubClass extends BaseClass { // BaseClass extends Equatable
  const SubClass({required this.name, required super.id});

  final String name;


  @override
  List<Object?> get props => _$props;
}

// generated code
extension _$SubClassAutoequal on SubClass {
  List<Object?> get _$props => [name, id];
}
```

## Field/Getter annotations

### Ignore

You can include fields or getter methods in `props` by annotating them with `@ignore`.

```dart
@ignore
final int random;
```

### Include

You can include fields or getter methods in `props` by annotating them with `@include`.

```dart
@include
String get id => _id;
```

## Build.yaml options

By default, the builder will ignore all getter methods in `props`, but you can change this behavior by adding the following to your `build.yaml` file:

```yaml
targets:
  $default:
    builders:

      autoequal_gen:
        enabled: true
        options:
          ... # view options below
```

### Options

To view a comprehensive list of options, view the [source code](https://github.com/mrgnhnt96/autoequal/blob/f7f79436de3197beb81930e3537db3676bdd4787/autoequal_gen/lib/gen/settings_interface.dart)

All options are optional.
All option's keys are formatted in `snake_case`.
