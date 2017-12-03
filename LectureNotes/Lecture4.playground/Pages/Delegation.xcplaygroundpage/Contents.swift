//: [Previous](@previous)
/*:

 ## Delegation ##
 ---
 - a very important (and simple) use of `protocol`s
   - a way to implement "blind communication" between a View and a Controller

 ### How it plays out... ###
 1. a View delcares a delegation `protocol`
    - i.e. what the View wants the Controller to do for it
 2. the View's API has a `weak` delegate property, whose type is that delegation `protocol`
 3. the View uses the delegate property to get / do things it couldn't on its own
 4. the Controller delcares that it implements the `protocol`
 5. the Controller sets itself as that delegate var
 6. the Controller implements the `protocol`
    - probably has lots of optional methods in it

 - Now the View is hooked up to the Controller, but remains generic / reusable (since it has no idea what the Controller is)
 - This mechanism is found throughout iOS, but was designed pre-closures in Swift
   - closures are sometimes a better option

*/
//: ### Example ###
import UIKit
weak var delegate: UIScrollViewDelegate?
//: >needs to be weak because the Controller has lots of pointers to the View, but this would point from the View back to the Controller

class MyViewController: UIViewController, UIScrollViewDelegate { }
//: probably in the `@IBOutlet` `didSet` for the scroll view, the Controller would do...
//: > `scrollView.delegate = self`

//: [Next](@next)
