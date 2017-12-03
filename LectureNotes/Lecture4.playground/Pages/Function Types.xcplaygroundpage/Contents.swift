//: [Previous](@previous)
/*:

 ## Function Types ##
 ---
 - can declare a variable (or parameter of a method or whatever) to be of type "function"
   - anywhere a type is allowed

*/
//: ### Example ###
import Foundation

var operation: (Double) -> Double
//: > is of type: "function that takes a `Double` and returns a `Double`"
operation = sqrt

let result = operation(4.0)

//: ### Closures ###
//: - create a function on the fly
//: - can do this in-line with a _closure_

func changeSign(operand: Double) -> Double {return -operand}
operation = changeSign
operation(4.0)

operation = { (operand: Double) -> Double in return -operand }
operation(4.0)

operation = { -$0*2 }
operation(4.0)
//: > using type inference and default parameter names, closures can be simplified a lot
//: > - e.g., $0 = 1st parameter, $1 = 2nd, $2 = 3rd, etc...

//: ### Where do we use closures ###
//: - often as arguments to methods
//:   - e.g., what should the method do when something asynchronous finishes and there's an error
//:   - maybe some method should repeatedly perform a function

let primes = [2.0, 3.0, 5.0, 7.0, 11.0]
let negativePrimes = primes.map { -$0 }
negativePrimes
let invertedPrimes = primes.map { 1.0 / $0 }
invertedPrimes
let primeStrings = primes.map { String($0) }
primeStrings
//: > if the last argument is a closure, you can move the closure outside the paratheses

//: ### Closures with property initialization ###
var someProperty: Int = {
    let beginningInt = 0
    let middleInt = beginningInt + 2 * 5
    let endingInt = middleInt / 2
    return endingInt
}()
//: > executed immediately by the ending `()`
//: > - especially useful with `lazy` property initialization

//: ### Capturing ###
//: - are **reference types**
//: - relevant variables are "captured" from surrounding code, and go into the heap too
//:   - everything stays in the heap together, until the whole closure can leave

var lifeTheUniverseAndEverything: Double = 42
operation = { lifeTheUniverseAndEverything * $0 }  // "captures" the variable because it's needed for the closure
var arrayOfOperations = [(Double) -> Double]()
arrayOfOperations.append(operation)
//: > this can easily create a memory cycle, if an object is captured

//: [Next](@next)
