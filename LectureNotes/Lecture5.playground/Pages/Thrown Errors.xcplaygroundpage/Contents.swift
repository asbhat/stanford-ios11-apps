//: [Previous](@previous)
/*:

 ## Thrown Errors ##
 ---
 - methods can throw errors

*/
//: Example
enum ExampleError: Error {
    case valid
    case invalid
}
func save() throws {}
func errorProneFunctionThatReturnsAnInt() throws -> Int {
    if 1 > 0 {
        return 1
    }
    throw ExampleError.invalid
}

//: in order to handle these errors...
do {
    try save()
} catch let error {
    // error will implement the Error protocol (e.g., NSError)
    // usually are enums that have associated values with error details
    throw error  // this would re-throw the error (only OK if this method also throws)
}

//: if you are certain a call will not throw...
try! save()  // will crash if save() actually throws

//: or can conditially try (return becomes an Optional)
let x = try? errorProneFunctionThatReturnsAnInt()

//: [Next](@next)
