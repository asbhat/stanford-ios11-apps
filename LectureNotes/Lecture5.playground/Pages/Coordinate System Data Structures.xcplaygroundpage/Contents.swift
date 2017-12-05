//: [Previous](@previous)
/*:

 ## Coordinate System Data Structures ##
 ---
 - `CGFloat`
   - always use this when doing something in the UIView coordinate system

*/
import UIKit

let aDouble = 19.2
let cgf = CGFloat(aDouble)
/*:

 - CGPoint
   - a struct with two CGFloats (`x` and `y`)

*/
var point = CGPoint(x: 37.0, y: 55.2)
point.y -= 30
point.x += 20.0
/*:

 - CGSize
   - also a struct with two CGFloats (`width` and `height`)

*/
var size = CGSize(width: 100.0, height: 50.0)
size.width += 42.5
size.height += 75
/*:

 - CGRect
   - a rectangle based on a `CGPoint` and `CGSize`

*/
let rect = CGRect(origin: point, size: size)

//: [Next](@next)
