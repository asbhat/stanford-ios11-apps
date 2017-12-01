//: [Previous](@previous)
/*:

 ## Protocols ##
 ---
 - _type_ that declares **functionality only**
   - can be used almost anywhere other types are used (`var`s, `func` parameters, etc.)
 - no data storage of any kind
 - essentially provides multiple (functionality) inheritance

 ### Uses ###
 1. Concise APIs
    - Instead of forcing the caller to pass a specific class, struct, or enum, can pass anything as long as the protocol is satisfied
    - A protocol is simply a collection of method and property declarations
 2. Making the API more flexible and expressive
 3. Blind, structured communication between View and Controller (delegation)
 4. Mandating behavior (e.g., the keys of a `Dictionary` must be hashable)
 5. Sharing functionality in disparate types (`String`, `Array`, and `CountableRange` are all `Collections`)
 6. Multiple inheritance (of functionality, not data)

 ### Aspects ###
 1. Declaration (which properties and methods are in the `protocol`)
 2. a `class`, `struct`, or `enum` that **claims** to implement the `protocol`
 3. the code in the above `class`, `struct`, or `enum` (or `extension`) that implements the `protocol`

 ### Optional methods in a `protocol` ###
 - Normally any `protocol` implementer must implement **all** the methods / properties in the `protocol`
 - However it is possible to make some methods `optional` (different to the `Optional` `enum` type)
 - Any `protocol` with `optional` methods must be marked `@objc`
 - Any `class` that implements a `protocol` with `optional` methods must inherit from `NSObject`
   - These sorts of protocols are often used for **delegation**
   - Except for delegation, `optional` methods are rarely used

*/
//: ### Delcaration Examples ###
protocol InheritedProtocol1 { }
protocol InheritedProtocol2 { }

protocol SomeProtocol: InheritedProtocol1, InheritedProtocol2 {
    var someProperty: Int { get set }
    func aMethod(arg1: Double, anotherArgument: String) -> Int
    mutating func changeIt()
    init(arg: Int)
}

/// This is rarely done.
protocol OnlyClassProtocol: class, InheritedProtocol1, InheritedProtocol2 {
    func changeIt()  // don't need mutating if restricting to only classes
}

protocol AnotherProtocol { }

class SomeSuperClass { }

class SomeClass: SomeSuperClass, SomeProtocol, AnotherProtocol {
    /// must be required, so all subclasses need to implement this (so protocols still work)
    required init(arg: Int) {
        someProperty = arg
    }

    var someProperty: Int = 0
    func aMethod(arg1: Double, anotherArgument: String) -> Int {
        print(anotherArgument)
        return Int(arg1)
    }

    func changeIt() {
        someProperty += 1
    }
}

enum SomeEnum: SomeProtocol, AnotherProtocol {
    case some, other, none
    init(arg: Int) {
        switch arg {
        case 1...Int.max:
            self = .some
        case 0:
            self = .other
        case Int.min..<0:
            self = .none
        default:
            fatalError()
        }
    }
    var someProperty: Int {
        get {
            return aMethod(arg1: 0, anotherArgument: "zero")
        }
        set {
            print(aMethod(arg1: Double(newValue), anotherArgument: "zero"))
        }
    }
    func aMethod(arg1: Double, anotherArgument: String) -> Int {
        print(anotherArgument)
        return Int(arg1)
    }
    mutating func changeIt() {
        someProperty += 1
    }
}

//: ### Extending a type to implement a `protocol` ###
struct SomeStruct {
    var someProperty = 0
}

extension SomeStruct: SomeProtocol {
    func aMethod(arg1: Double, anotherArgument: String) -> Int {
        print(anotherArgument)
        return Int(arg1)
    }
    mutating func changeIt() {
        someProperty += 1
    }
    init(arg: Int) {
        someProperty = arg
    }
}

//: ### Using `protocol`s like the type they are! ###
import UIKit

protocol Moveable {
    mutating func move(to point: CGPoint)
}
class Car: Moveable {
    func move(to point: CGPoint) { }
    func changeOil() { }
}
struct Shape: Moveable {
    var location = CGPoint.zero
    mutating func move(to point: CGPoint) {
        location = point
    }
    func draw() { }
}

let prius = Car()
let square = Shape()

var thingToMove: Moveable = prius
thingToMove.move(to: CGPoint(x: 1, y: 2))
//: > `thingToMove.changeOil()` fails! Because `Moveable` things don't know how to `changeOil()`

thingToMove = square
let thingsToMove: [Moveable] = [square, prius]

func slide(_ slider: inout Moveable, to position: CGPoint) {
    slider.move(to: position)
}

slide(&thingToMove, to: CGPoint(x: 6, y: 9))
thingToMove = prius
slide(&thingToMove, to: CGPoint(x: 6, y: 9))

protocol Slippery { }
func slipAndSlipe(x: Slippery & Moveable) { }  // can require multiple protocol implementations
//: > Can't do `slipAndSlide(prius)` (only implements `Moveable`)

//: [Next](@next)
