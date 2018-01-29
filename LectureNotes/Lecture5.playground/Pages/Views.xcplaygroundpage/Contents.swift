//: [Previous](@previous)
/*:

 ## Views ##
 ---
 - a view (i.e. `UIView` subclass) represents a rectangular area
   - in a coordinate space
   - used for drawing
   - handles touch events (double tapping, pan, pinching, etc.)

 - Hierarchical
   - only has 1 superview (`var superview: UIView?`)
   - can have many (or zero) subviews (`var subviews: [UIView]`)
   - order matters (later in the array are on top of those earlier)
   - a view can clip subviews to its own bounds (defaults to false)

 - UIWindow
   - at the very top of the view hierarchy (includes the status bar)
   - usually only one UIWindow in the entire application (focus on views)

 - hierarchy _most often_ constructed graphically (Xcode interface builder)
 - but can be done in code as well
   - `func addSubview(_ view: UIView)`
   - `func removeFromSuperview()`

 - top-most (useable) view is in the Controller's `var view: UIView`
   - the `view`'s bounds will change on rotation
   - most likely programmatically add subviews to this


 ### Initializing a UIView ###
 - try to avoid if possible!
   - but having one is slightly more common than a UIViewController

*/
//: Example initializer
import UIKit

class ExampleView: UIView {

    func setup() { }

    override init(frame: CGRect) {  // needed if the UIView is created in code
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {  // needed if the UIView comes out of a storyboard
        super.init(coder: aDecoder)
        setup()
    }
}
/*
 - alternative to inits in a UIView: `awakeFromNib()`
   - called if the UIView came out of a storyboard
   - is called immediately after initialization is complete
   - all objects that inherit from NSObject in a storyboard are sent this
   - order is not guaranteed (so don't try to message other objects here)


*/
//: [Next](@next)
