//: [Previous](@previous)
/*:
 ## Memory Management ##
 ---

 ### Automatic Reference Counting (ARC) ###
 - Counts references to each reference type object
 - When references go to zero, object is (automatically) tossed

 ### Influencing ARC ###
 - `strong` (default) - normal reference counting
 - `weak`
   - will set to `nil` if it's the only reference left
   - only works on Optional pointers (since it could be `nil`)
   - will **never** keep an object in the heap
   - Example: `outlet`s (strongly held by the view hierarchy, so `outlet`s can be `weak`)
 - `unowned`
   - "don't reference count this; crash if I'm wrong"
   - very rarely used
   - usually only to break memory cycles between objects

*/
//: [Next](@next)
