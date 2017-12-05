//: [Previous](@previous)
/*:

 ## Creating Views ##
 ---

 ### Storyboard ###
 - drag out a generic `UIView`
 - change class using the `Identity Inspector` tab to custom subclass

 ### Code ###
*/
import UIKit
import PlaygroundSupport

let myViewFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100.0, height: 50.0))
let newView = UIView(frame: myViewFrame)
//: > `frame` defaults to `CGRect.zero`

//: Example

class ExampleViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .black

        let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
        let label = UILabel(frame: labelRect)
        label.text = "Hello"
        label.textColor = .white

        view.addSubview(label)
        self.view = view
    }
}

PlaygroundPage.current.liveView = ExampleViewController()
//: [Next](@next)
