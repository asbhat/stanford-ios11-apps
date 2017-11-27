//: [Previous](@previous)
/*:
 ## Ranges ##
 ---
*/
//: ### Closed Countable Range (includes upper bound) ###
//: `Int`s
for i in 0...5 {
    i
}
//: `Float`s
for i in stride(from: 0.5, through: 15.2, by: 0.3) {
    i
}
//: ### Open Countable Range (excludes upper bound) ###
//: `Int`s
for i in 0..<5 {
    i
}
//: `Float`s
for i in stride(from: 0.5, to: 15.2, by: 0.3) {
    i
}
//: [Next](@next)
