//: [Previous](@previous)
/*:
 ## Optionals ##
 ---

 A regular type in swift (an `enum`).
*/
//: a code example
enum OptionalExample<T> {  // a generic type
    case none
    case some(T)  // associated data of type T
}

//: same as `var hello = String?`
var hello: OptionalExample<String> = .none
//: same as `var hello: String? = "hello"`
hello = .some("hello")
//: same as `var hello: String? = nil`
hello = .none

//: [Next](@next)
