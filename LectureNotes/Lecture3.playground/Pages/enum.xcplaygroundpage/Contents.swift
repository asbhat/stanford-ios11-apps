//: [Previous](@previous)
/*:
 ## `enum` ##
 ---

 Another variety of data structure (besides `class` and `struct`).
 It can only have discrete states.
 Is a **value type** (like `struct`), so it's copied and passed around.

*/
enum FastFoodMenuItem {
    case hamburger
    case fries
    case drink
    case cookie
}

//: ### Associated Data ###
//: each state can (but does not have to) have its own 'associate data'
enum AssociatedFastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)  // the unnamed `String` is the brand, e.g., Coke
    case cookie
}

enum FryOrderSize {
    case large
    case small
}

//: setting the value of an `enum`
var menuItem = AssociatedFastFoodMenuItem.hamburger(numberOfPatties: 2)
let otherItem: AssociatedFastFoodMenuItem = .cookie

//: checking an `enum`s state
switch menuItem {
case .hamburger: "burger"
case .fries: "fries"
case .drink: "drink"
case .cookie: "cookie"
}

//: `break`
//: if you don't want to do anything
switch menuItem {
case .hamburger: break
case .fries: "fries"
case .drink: "drink"
case .cookie: "cookie"
}

//: `default`
menuItem = .cookie
switch menuItem {
case .hamburger: break
case .fries: "fries"
default: "other"
}

//: multiple lines allowed
menuItem = .fries(size: .large)
switch menuItem {
case .hamburger: "burger"
case .fries:
    "yummy"
    "fries"
case .drink:
    "drink"
case .cookie: "cookie"
}

//: retrieving the associated data (using `let`)
menuItem = .drink("Coke", ounces: 32)
switch menuItem {
case .hamburger(let pattyCount): "a burger with \(pattyCount) patties!"
case .fries(let size): "a \(size) order of fries!"
case .drink(let brand, let ounces): "a \(ounces)oz \(brand)"
case .cookie: "a cookie!"
}

//: methods and computed properties allowed, but no stored properties
enum FastFoodItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie

    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
        case .hamburger(let pattyCount): return pattyCount == number
        case .fries, .cookie: return true
        case .drink(_, let ounces): return ounces == 16
        }
    }
    var calories: Int {
        return 1_000_000
    }
    mutating func switchToBeingACookie() {
        self = .cookie
    }
}

//: [Next](@next)
