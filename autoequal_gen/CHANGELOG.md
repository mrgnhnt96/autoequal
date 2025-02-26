# 0.9.5 | 2.22.2025

- Update dependencies

# 0.9.4 | 2.8.2025

- Update dependencies

# 0.9.1 | 1.17.2023

- deps: Update range for path to support
- tests: add generator tests

# 0.9.0 | 1.11.2023

- BREAKING: remove support for mixin
- BREAKING: update annotation constants to omit `Autoequal` suffix
- feat: support public super class fields within props
- feat: support auto including class that use Equatable and have a `props` getter
- refactor: extract files for better maintainability and readability

# 0.8.0 | 1.9.2023

- Remove deprecated `_autoequalProps`

# 0.7.1

- Refactor autoequal_gen to use code_builder instead of raw Strings

# 0.6.0

- Require Dart 3.0 or later
- Add final modifier to all classes
- Migrate from pedantic to lints
- Update dependencies

Thank you [techouse](https://github.com/techouse) for your contributions!!

# 0.5.1

- Fixed use of `autoequal_gen` with `analyzer: 5.0.0`

# 0.5.0

- Added ability to use getters for generated `props`
- Allowed to use `@autoequal` with abstract class
- Improved inheritance with `@autoequal`
- Mixin improvements
- Generated props name changed to `_$props` to fit the code convention. `_autoequalProps` is now deprecated and will be
  removed in future releases.

Thanks a lot to [mrgnhnt96](https://github.com/mrgnhnt96) for these changes

# 0.4.1

- analyzer updated

# 0.4.0

- Dependencies updated
- build_runner updated to 2.2.0
- Ready to Dart 2.17

# 0.3.0

- build_runner updated to 2.1.5

# 0.2.0

- Migrated to null-safety
- The version of the equatable lib upgraded to 2.0

# 0.1.2

- Fixed and improved @autoequalMixin.

# 0.1.1

- Added @autoequalMixin.

# 0.1.0

- Initial version.
