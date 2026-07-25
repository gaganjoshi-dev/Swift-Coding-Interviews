# Swift Interview Questions

A growing collection of Swift interview topics with concise explanations and runnable examples.

## Topics

- [Property Wrappers](Topics/PropertyWrapper.swift)
  - `wrappedValue`
  - `projectedValue` and `$` syntax
  - Applying read and write policies to properties

- [Higher-Order Functions](Topics/HigherOrderFunction.swift)
  - Custom `myFilter`, `myMap`, and `myReduce` on `Array`
  - Passing behavior as a closure
  - What a higher-order function really is

- [Testing Private Functions with Hooks](Topics/Hooks.swift)
  - Why `private` is reachable from same-file extensions
  - `#if DEBUG` test seams instead of loosening access control
  - Namespacing test helpers behind a `hooks` object

## Run an Example

```bash
swift Topics/PropertyWrapper.swift
swift Topics/HigherOrderFunction.swift
# Open Topics/Hooks.swift in an Xcode test target (uses XCTest + #if DEBUG hooks)
```

## License

This project is available under the [MIT License](LICENSE).
