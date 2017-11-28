//: [Previous](@previous)
/*:
 ## Computed Properties ##
 ---
The value of a property can be _computed_ rather than _stored_.
*/
//: stored property example
var foo: Double
//: computed property example
var bar: Double {
    get {
        // return calculated value of `foo`
        return 0.0
    }
    set(newBar) {
        // do something when `bar` changes to `newBar` value
        // can use `newValue` when no name is specified
    }
    // if `set` is not implemented, the property becomes read-only
}
//: E.g. see `indexOfOneAndOnlyFaceUpCard` in Concentration app.
//: [Next](@next)
