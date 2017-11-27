//: [Previous](@previous)
/*: 
 ## Tuples ##
 ---

 Just a grouping of values.
 Can be used anywhere a Type is.
 */
//: elements named on access
let x: (String, Int, Double) = ("hello", 5, 0.85)
let (word, number, value) = x
word
number
value

//: elements named on declaration (this is **preferred**)
let y: (w: String, i: Int, v: Double) = ("hello", 5, 0.85)
y.w
y.i
y.v

//: can still name elements on access
let (wrd, num, val) = y

//: ### Tuples are return values
//: `func`s can only return one thing, but that thing can be a tuple
func getSize() -> (weight: Double, height: Double) { return (250, 80) }

let size = getSize()
"weight is \(size.weight)"
"height is \(size.height)"
//: [Next](@next)
