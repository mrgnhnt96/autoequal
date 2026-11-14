| Package                 | Version                                                                                                                  |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `equatable_annotations` | [![Pub Package](https://img.shields.io/pub/v/equatable_annotations.svg)](https://pub.dev/packages/equatable_annotations) |
| `equatable_gen`         | [![Pub Package](https://img.shields.io/pub/v/equatable_gen.svg)](https://pub.dev/packages/equatable_gen)                 |

[![GitHub stars](https://img.shields.io/github/stars/mrgnhnt96/equatable_gen?style=social)](https://github.com/mrgnhnt96/equatable_gen)

Provides [Dart Build System](https://pub.dev/packages/build) builder for generating `List<Object?> _$props` private extensions for classes using [Equatable](https://pub.dev/packages/equatable).

## Compatibility fork

This fork supports analyzer 11–14, build 4 and source_gen 4 for both
`autoequal_gen` and `equatable_gen`. The legacy `autoequal_gen` package is
retained from v0.9.5 so existing `@autoequal` / `@Autoequal()` annotations and
`_$props` extensions remain supported alongside `@generateProps`.

Use the matching Git package path (`autoequal_gen` or `equatable_gen`) and pin
the dependency to a tested commit. Annotation packages remain unchanged:
`autoequal: ^0.9.1` and `equatable_annotations: ^1.2.0`.

## Usage

### Setup

1. Add to your `pubspec.yaml`:

   ```yaml
   dependencies:
     equatable_annotations: ^latest_version

   dev_dependencies:
     equatable_gen: ^latest_version
     build_runner: ^latest_version
   ```

2. Create a `build.yaml` file in your project root:

   ```yaml
   targets:
     $default:
       builders:
         equatable_gen:
           enabled: true
           options:
             auto_include: true
   ```

3. Add part declarations to your files:

   ```dart
   part 'your_file_name.g.dart';
   ```

4. Run code generation:

   ```bash
   flutter pub run build_runner build
   ```

## Zero Annotation Approach

With `auto_include: true` in your `build.yaml`, **no annotations are needed**. The generator automatically processes:

- Classes that extend `Equatable`
- Classes that use `EquatableMixin`
- Classes that inherit from a class using either of the above

All you need is:

```dart
class MyClass extends Equatable {
  const MyClass({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => _$props; // `_$props` will be automatically generated
}
```

The generator creates:

```dart
extension _$MyClassequatable_annotations on MyClass {
  List<Object?> get _$props => [id, name];
}
```

> [!IMPORTANT]
> The `props` will not be generated if the `props` getter is not defined in the class.

## Inheritance

Inheritance works automatically. Fields from parent classes are included:

```dart
class ChildClass extends ParentClass { // ParentClass uses Equatable
  const ChildClass({required this.name, required super.id});

  final String name;

  @override
  List<Object?> get props => _$props;
}

// Generated:
extension _$ChildClassequatable_annotations on ChildClass {
  List<Object?> get _$props => [name, id]; // Both fields included
}
```

## Field/Getter Control

### Exclude Fields

Exclude fields from props with `@ignore`:

```dart
import 'package:equatable_annotations/equatable_annotations.dart';

@ignore
final String sensitiveData;
```

### Include Getters

Include getters in props with `@include`:

```dart
import 'package:equatable_annotations/equatable_annotations.dart';

@include
String get fullName => '$firstName $lastName';
```

## Advanced Configuration

Customize behavior in your `build.yaml`:

```yaml
targets:
  $default:
    builders:
      equatable_gen:
        enabled: true
        options:
          auto_include: true # defaults to false
          include: # Only include classes matching patterns (regex)
            - User.*
          exclude: # Exclude classes matching patterns (regex)
            - .*ViewModel
          include_getters: true # defaults to false
```

## Manual Annotation (Alternative)

If you prefer explicit control, you can use annotations:

```dart
import 'package:equatable_annotations/equatable_annotations.dart';
import 'package:equatable/equatable.dart';

part 'some_class.g.dart';

@generateProps
class SomeClass extends Equatable {
  const SomeClass({required this.id});

  final String id;

  @override
  List<Object?> get props => _$props;
}
```
