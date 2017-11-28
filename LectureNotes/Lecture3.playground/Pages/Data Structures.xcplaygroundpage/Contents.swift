//: [Previous](@previous)
/*:
 ## Data Structures ##
 ---

 Four essential data structures:
 - `class`
 - `struct`
 - `enum`
 - `protocol`

*/
/*:

 ### `class` ###
 - supports object-oriented design
 - single inhertiance (both functionality and data)
 - reference type (stored in the heap and pointers passed around)
 - heap is kept clean by swift via _reference counting_ (not garbage collection) - see [Memory Management](Memory%20Management) for more
 - Examples: `ViewController`, `UIButton`, `Concentration`

 ### ` struct` ###
 - value type
 - copy on write (very efficient)
   - so need to mark `mutating` methods
 - no inhertiance (of data)
 - mutability controlled via `let` / `var`
 - supports functional-programming design
 - Examples: `Card`, `Array`, `Dictionary`, `String`, `Character`, `Int`, `Double`, `UInt32`

 ### `enum` ###
 - used for variables that can have one of a discrete set of values
 - each option can have associated data
 - value type
 - can **only** have methods and computed properties
 - Example: we'll create a `PlayingCard` struct that uses `Rank` and `Suit` `enum`s

 ### `protocol` ###
 - _type_ that declares **functionality only**
 - no data storage of any kind
 - essentially provides multiple (functionality) inheritance

*/
//: [Next](@next)
