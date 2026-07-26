// MARK: - Interview Topic: Thread-Safe Stack with a Dispatch Barrier
//
// Question: “Make this Stack thread safe.”
//
// The bug: `Array` is not thread safe. Two threads calling `push` at the same
// time can both mutate the buffer at once — lost elements, or a crash.
//
// Weak answers:
//   • “Wrap every access in a serial queue.” → correct, but reads block reads
//   • “Use a lock.”                          → works, easy to forget an unlock
//   • “Make it an actor.”                    → good in async code, but the
//                                              interviewer is asking about GCD
//
// Good answer: a reader-writer lock via a concurrent queue plus a barrier.
//   Reads  — `queue.sync { }`, so many readers run in parallel.
//   Writes — `queue.sync(flags: .barrier) { }`, which waits for every in-flight
//            block to finish, runs alone, and only then lets others resume.
//
// The detail that decides this question: `.barrier` only means something on a
// CONCURRENT queue. `DispatchQueue(label:)` is serial by default, where blocks
// already run one at a time — the flag is silently a no-op and you get none of
// the parallel-read benefit you think you're getting.
//
// Watch out: never call `queue.sync` from inside a block already running on
// `queue`. That deadlocks. Keep the critical sections tiny and non-nested.

import Foundation

final class Stack {
    private var array = [Int]()
    private let queue = DispatchQueue(label: "com.myapp.stack", attributes: .concurrent)

    // Write: exclusive via barrier.
    func push(_ element: Int) {
        queue.sync(flags: .barrier) {
            array.append(element)
        }
    }

    // Write: exclusive via barrier.
    func pop() -> Int? {
        queue.sync(flags: .barrier) {
            array.isEmpty ? nil : array.removeLast()
        }
    }

    // Read: concurrent with other reads, blocked only by a barrier write.
    func noOfElement() -> Int {
        queue.sync {
            array.count
        }
    }
}

let stack = Stack()
stack.push(1)
stack.push(2)
stack.push(3)

print(stack.pop() ?? 0)   // 3
print(stack.pop() ?? 0)   // 2

let number = stack.noOfElement()
print(number)             // 1

// Proof it holds up under contention: 1000 pushes from many threads at once.
let contended = Stack()
DispatchQueue.concurrentPerform(iterations: 1000) { index in
    contended.push(index)
}
print(contended.noOfElement())   // 1000 — never less, never a crash
