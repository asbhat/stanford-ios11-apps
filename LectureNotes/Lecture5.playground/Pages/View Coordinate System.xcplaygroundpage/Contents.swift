//: [Previous](@previous)
/*:

 ## View Coordinate System ##
 ---
 - origin is in the upper left
   - this mean increasing y is down (the opposite of cartesian coordinates!)
 - units are **points**, not pixels
 - see UIView's `var contentScaleFactor: CGFloat` for pixels per point
   - usually 2, but sometimes 1 or 3
 - boundaries (for drawing)
   - `var bounds: CGRect` (in its own coordinate system)
 - UIView position (where you are)
   - `var center: CGPoint` the center in its **superview's coordinate system**
   - `var frame: CGRect` the rectangle containing the UIView in its **superview's coordinate system**

 ### Bounds vs. Frame ###
 ![](bounds-vs-frame.png)
 - views can be rotated
 - View B’s `bounds` = ((0,0),(200,250))
 - View B’s `frame` = ((140,65),(320,320))
 - View B’s `center` = (300,225)

*/
//: [Next](@next)
