// MARK: - Interview Topic: Property Wrappers
//
// Most posts say property wrappers are "syntactic sugar for getters and setters."
// True — also incomplete.
//
// What actually matters: a property wrapper is a *policy object*.
// You attach a rule to a property, and Swift routes every read and write through that rule.
//
// Two doors on one property:
//   • wrappedValue  → the public value callers see (e.g. User().rollno)
//   • projectedValue → a second view via `$` (e.g. User().$rollno)
//
// `$` is not decoration. It is Swift's projection syntax for `projectedValue`.
// SwiftUI's `@State` / `$binding` pattern is the production version of the same idea.
//
// This `@NonNegative` example clamps on *get*, not *set*:
//   • Storage can still hold a negative number.
//   • Callers always read a non-negative result.
// That is a presentation rule, not strict storage validation.
// (Some wrappers clamp in `set` so invalid values never land in storage.)

@propertyWrapper
struct NonNegative {

    var value: Int

    var wrappedValue: Int {
        set { value = newValue }
        get {
            if value < 0 {
                return 0
            }
            return value
        }
    }

    init(wrappedValue: Int) {
        self.value = wrappedValue
    }

    /// Side channel: raw storage + 10. Accessed as `$propertyName`.
    var projectedValue: Int {
        return value + 10
    }
}

struct User {
    @NonNegative var rollno = -34
}

// When you write `@NonNegative var rollno = -34`, Swift stores a `NonNegative`
// wrapper and exposes `rollno` as `wrappedValue`.
//
print(User().rollno)   // 0     — getter clamps negative storage to 0
print(User().$rollno)  // -24   — projectedValue: -34 + 10

// Same underlying storage. Two intentional outputs. That is the whole lesson.
