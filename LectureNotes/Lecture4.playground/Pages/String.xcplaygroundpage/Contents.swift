//: [Previous](@previous)
/*:

 ## String ##
 ---
 - A `String` is a collection of Unicodes
 - A `Character` is what a human would think of as a single lexical character
 - a single `Character` may contain multiple Unicodes

 - because of this, `String`s are indexed by `String.Index`

*/
//: ### Characters in a String ###
let pizzaJoint = "café pesto"
let firstCharacterIndex = pizzaJoint.startIndex
let fourthCharacterIndex = pizzaJoint.index(firstCharacterIndex, offsetBy: 3)
let fourthCharacter = pizzaJoint[fourthCharacterIndex]

if let firstSpace = pizzaJoint.index(of: " ") {  // returns `nil` if " " not found
    let secondWordIndex = pizzaJoint.index(firstSpace, offsetBy: 1)
    let secondWord = pizzaJoint[secondWordIndex..<pizzaJoint.endIndex]
    secondWord
}
//: > the `..<` above creates a `Range` of `String.Index`

//: **Another way to find the second word**:
pizzaJoint.split(separator: " ")[1]
//: > `split(separator:)` returns an `Array<String>`, but it might be empty, so be careful!

//: **Loop through characters**
for c in pizzaJoint {
    c
}

//: `Array` of characters
let characterArray = Array(pizzaJoint)

//: A `String` is a `struct` (value type)
var s = pizzaJoint
s.insert(contentsOf: " foo", at: s.index(of: " ")!)

s.replaceSubrange(..<s.endIndex, with: "new contents")
//: > Swift will fill in the start or end index if you leave one blank (can't always do this)

//: [Next](@next)
