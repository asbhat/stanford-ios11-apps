//: [Previous](@previous)
/*:

 ## Advanced Use of Protocols ##
 ---

 ### "Multiple Inheritance" with `protocol`s
 - `CountableRange` implements many `protocol`s, but here are a couple important ones...
   - `Sequence` - `makeIterator` (and thus supports `for in`)
   - `Collection` - subscripting (i.e. []), `index(offsetBy:)`, `index(of:)`, etc.

 - Why?
   - So different objects can have similar functionality
   - `Array` implements both `Sequence` and `Collection`, but...
   - `Dictionary`, `Set`, and `String` all also implement both!

 - You can also create default implementations! (not just declarations)

 ### `protocol` & `extension`

 - An `extension` can be used to add **default implementation** to a `protocol`
 - This can be leveraged for Functional Programming (an evolution, sort of, of Object-Oriented Programming)

*/
//: [Next](@next)
