//: [Previous](@previous)
/*:

 ## NSAttributedString ##
 ---
 - a `String` with attributes attached to each character
   - basically an object that has a `Dictionary` of attributes for each character in the `String` (e.g., font, color, etc.)

*/
//: ### Creating and using an NSAttributedString
//: - E.g., make a label have orange, outlined text...`String`

import UIKit

let attributes: [NSAttributedStringKey: Any] = [
    .strokeColor : UIColor.orange,
    .strokeWidth : 5.0
]

//: > - type cannot be inferred here (is an objective-c API living in Swift)
//: > - negative `strokeWidth` means fill, positive means outline

let attribtext = NSAttributedString(string: "Flips: 0", attributes: attributes)
var label = UILabel()

label.attributedText = attribtext

//: ### Peculiarities of `NSAttributedString` ###
//: - completely different data structure to `String`
//: - anything starting with "NS" is an Objective-C style class
//: - it's a `class` (not a `struct`)
//:   - e.g., to make it mutable, need to use `NSMutableAttributedString`
//:   - built with `NSString` in mind (not `String`)
//: - there is some bridging (use `init`s) between Swift and Obj-c
//:   - but don't expect indexing to line up (especially with "wacky" multi-unicode characters)


//: [Next](@next)
