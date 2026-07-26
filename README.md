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

- [Custom View Modifier](Topics/CustomViewModifier.swift)
  - Conforming to `ViewModifier` and styling `content` in `body`
  - A `View` extension so usage reads like a built-in modifier
  - Naming a repeated style so it lives in one place

- [Thread-Safe Stack with a Dispatch Barrier](Topics/DispatchBarrierThreadSafe.swift)
  - Reader-writer lock: concurrent reads, `.barrier` writes
  - Why `.barrier` is a no-op unless the queue is `.concurrent`
  - Keeping every array access on the same queue to avoid data races

## Run an Example

```bash
swift Topics/PropertyWrapper.swift
swift Topics/HigherOrderFunction.swift
swift Topics/DispatchBarrierThreadSafe.swift
# Open Topics/Hooks.swift in an Xcode test target (uses XCTest + #if DEBUG hooks)
# Open Topics/CustomViewModifier.swift in an Xcode SwiftUI project or preview
```

## License

This project is available under the [MIT License](LICENSE).
