//: [Previous](@previous)
/*:
 ## Access Control ##
 ---

 Protecting internal implementations.
 Use these keywords to decide the public facing API (Application Programming Interface).

 - `internal` (default) - useable by any object in the app or framework
   - don't need to ever type this, since it's the default
 - `private` - only callable within this object
 - `private(set)` - readable outside the object, but not settable
 - `fileprivate` - accessible by any code in this file
 
 frameworks only
 - `public` - can be used by objects outside the framework
 - `open` - `public` and objects outside the framework can subclass this

 a good strategy is to make as much `private` as possible.

*/
//: [Next](@next)
