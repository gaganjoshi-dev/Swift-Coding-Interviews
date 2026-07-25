// MARK: - Interview Topic: Higher-Order Functions
//
// If you can rewrite map, filter, and reduce, you don’t just use higher-order
// functions — you understand them.
//
// Common interview question:
//   “Can you implement custom higher-order functions on Array?”
//
// One-liners:
//   myFilter — Returns only the elements that pass a condition.
//   myMap    — Transforms every element into a new value (and possibly a new type).
//   myReduce — Combines all elements into a single result using an initial value.
//
// What a higher-order function really is:
//   A function that takes another function as an argument, or returns a function
//   as its result (or both).
//
// Three functions. Three jobs. Same idea: pass behavior as a closure.

extension Array {

    func myFilter(_ closure: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        for value in self {
            if closure(value) {
                result.append(value)
            }
        }
        return result
    }

    func myMap<T>(_ closure: (Element) -> T) -> [T] {
        var result = [T]()
        for value in self {
            result.append(closure(value))
        }
        return result
    }

    func myReduce<T>(
        _ initialResult: T,
        _ nextPartialResult: (T, Element) -> T
    ) -> T {
        var result = initialResult
        for element in self {
            result = nextPartialResult(result, element)
        }
        return result
    }
}

var array = [1, 2, 3, 4, 5]

var filterArray = array.myFilter {
    $0 % 2 == 0
}

var mapArray = array.myMap {
    String($0 * $0)
}

print(filterArray)   // [2, 4]
print(mapArray)      // ["1", "4", "9", "16", "25"]

var reduceArray = array.myReduce(0, +)
print(reduceArray)   // 15
