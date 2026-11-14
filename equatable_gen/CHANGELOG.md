## Unreleased

- Support analyzer 11–14 using `isOriginGetterSetter` in place of the removed
  `FieldElement.isSynthetic` API.
- Add regression coverage for annotation-driven generation, inherited fields,
  private/static fields and explicit getter inclusion.

## 1.3.2 | 3.27.26

### Fixes

- Honor `@ignore` / `@include` on getters that override a superclass field.

## 1.3.1 | 3.6.25

### Enhancements

- Extend analyzer support to 10.x (`>=8.0.0 <11.0.0`)

## 1.3.0 | 12.16.25

### Enhancements

- Update dependencies
  - Thanks [@techouse](https://github.com/techouse) for the contribution! 🎉

## 1.2.0 | 9.18.25

### Enhancements

- Update dart sdk to 3.7.0
- Update dependencies
  - A big thank you to [@techouse](https://github.com/techouse) for their hard work! 🎉

## 1.1.1 | 9.11.25

### Enhancements

- Migrate to `Element2` API
- Update dependencies
  - Thanks [@techouse](https://github.com/techouse) for the contribution! 🎉

## 1.0.4 | 4.24.25

### Enhancements

- Update README

## 1.0.3 | 4.24.25

### Enhancements

- Fix class name formatting that impacted pub score
  - Thanks (again) [@techouse](https://github.com/techouse) for the report and fix! 🎉

## 1.0.2 | 4.23.25

### Fixes

- Fixed dependency issue where `equatable_gen` was could not use the correct version of `equatable_annotations`
  - Thanks [@techouse](https://github.com/techouse) for the report and fix!

## 1.0.1 | 4.11.25

- Initial Release

Replaces [`autoequal_gen`](https://pub.dev/packages/autoequal_gen) package
