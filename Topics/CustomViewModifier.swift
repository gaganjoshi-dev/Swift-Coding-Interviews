// MARK: - Interview Topic: Custom View Modifier
//
// Question: “Can you write a custom view modifier?”
//
// It is not a trick question. The interviewer wants a quick signal: can you move
// past `.padding().background(.red)` pasted on every screen, and actually *name*
// that look?
//
// A custom view modifier turns a repeated SwiftUI style into a named, reusable API.
//
// A strong answer covers four things:
//   • Conform to `ViewModifier`
//   • Style `content` inside `body`
//   • Expose a `View` extension so usage reads like a built-in modifier
//   • Explain why — reuse, clarity, one place to change the style
//
// Most candidates know modifiers exist. Fewer can build one cleanly under pressure.

import SwiftUI

struct PaddedRedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.red)
    }
}

// The extension lets you call .paddedRedBackground() instead of typing
// .modifier(PaddedRedBackground()) every time — so it feels like a normal
// SwiftUI modifier.
extension View {
    func paddedRedBackground() -> some View {
        modifier(PaddedRedBackground())
    }
}

struct Parent: View {
    var body: some View {
        Text("Hello World")
            .paddedRedBackground()
    }
}
