//: [Previous](@previous)
/*:

 ## Any & AnyObject ##
 ---
 - commonly used for compatibility with old Obj-C APIs
   - not many remaining in iOS 11
 - variables of type Any can hold anything (AnyObject can hold any class)
   - cannot invoke methods on Any...
   - need to convert to a concrete type first

 ### Examples ###
 - `NSAttributedString`
   - dictionary needs to be [ `NSAttributedStringKey` : `Any`]
 - function arguments
   - `func prepare(for segue: UIStoryboardSegue, sender: Any?)`

 ### Conversion ###
 - done using the `as?` keyword
   - generates an Optional as conversion isn't always possible
 - **check** to see if something can be converted with the `is` keyword (`-> Bool`)

*/
//: Example
import Foundation

var unknown: Any
unknown = "hello"
if let foo = unknown as? String { foo.capitalized }

//: [Next](@next)
