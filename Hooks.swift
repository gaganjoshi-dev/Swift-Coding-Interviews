// MARK: - Interview Topic: Testing Private Functions with Hooks
//
// Question: “How do you unit test a private function in Swift?”
//
// Weak answers:
//   • “You can’t.”
//   • “Make it public.”            → API leakage
//   • “Make everything internal.”  → works, but weakens encapsulation
//   • “Only test the big public flows.” → slow, brittle, unclear failures
//
// Good answer: keep it private in production, and expose a DEBUG-only test entry point.
//
// Why this compiles: in Swift, a `private` member is visible to extensions
// declared in the *same file*. So a `#if DEBUG` extension can reach it.
//
// For one helper, a simple DEBUG passthrough is enough.
// Interviews often push further: keep test helpers from looking like real feature APIs.
// That’s where hooks come in — `sut.hooks.myPrivate()` is clearly a test seam.
// The hooks type disappears entirely in release builds.

import XCTest

class Sample {
    private func myPrivate() {
        print("baseFunction called")
    }
}

#if DEBUG
extension Sample {
    func test_myPrivate() {
        myPrivate()
    }
}
#endif

#if DEBUG
extension Sample {
    struct Hooks {
        fileprivate let target: Sample

        func myPrivate() {
            target.myPrivate()
        }
    }

    var hooks: Hooks {
        Hooks(target: self)
    }
}
#endif

#if DEBUG
final class SampleTests: XCTestCase {
    func test_myPrivate() {
        let sut = Sample()
        sut.hooks.myPrivate()
    }
}
#endif
