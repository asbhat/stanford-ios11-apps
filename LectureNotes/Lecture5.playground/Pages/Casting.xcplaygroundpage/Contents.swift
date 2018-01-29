//: [Previous](@previous)
/*:

 ## Casting ##
 ---
 - can cast anything (not just `Any` & `AnyObject`)
 - mostly used to cast an object from a superclass to a subclass
 - could also cast any type to a `protocol` it implements

*/
//: Example of "downcasting"
import UIKit

class SubclassVC: UIViewController {
    func subclassOnlyMethod() -> String { return "subclass onry!" }
}

let vc: UIViewController = SubclassVC()
// vc.subclassOnlyMethod() -- can't do this!

if let subvc = vc as? SubclassVC {
    subvc.subclassOnlyMethod()
}

//: [Next](@next)
