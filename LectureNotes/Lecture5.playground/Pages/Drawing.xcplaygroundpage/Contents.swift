//: [Previous](@previous)
/*:

 ## Drawing ##
 ---

*/
//: ### UIBezierPath Example ###
import UIKit
import PlaygroundSupport

class BezierExampleViewController: UIViewController {
    override func loadView() {
        let view = BezierDrawingView()
        view.backgroundColor = .black

        view.isOpaque = false

        self.view = view
    }
}

class BezierDrawingView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 80, y: 50))
        path.addLine(to: CGPoint(x: 140, y: 150))
        path.addLine(to: CGPoint(x: 10, y: 150))
        path.close()

        UIColor.green.withAlphaComponent(0.5).setFill()
        UIColor.red.setStroke()
        path.lineWidth = 3.0
        path.fill()
        path.stroke()
    }
}

PlaygroundPage.current.liveView = BezierExampleViewController()
//: [Next](@next)
