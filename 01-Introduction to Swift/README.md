# Introduction to Swift (Days 1-15)

## Day 1 – variables, simple data types, and string interpolation

Giving some keywords: *variables, strings, integers, Multi-line strings, doubles, booleans, string interpolation, constants, type annotations*

## Day 2 – arrays, dictionaries, sets, and enums

I feel familiar with arrays and enums (with associated values, raw values).

Interesting! **Sets** are like arrays, but *random order* and every item *unique*.
```swift
let colors = Set(["red", "green", "blue"])
```
Never used sets till now.

Oh, look at this exotic thing, a **tuple**!
```swift
var name = (first: "Taylor", last: "Swift")
```
Never used a tuple till now.

Ah, around the corner is a dictionary:
```swift
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
```
Only used a dictionary when returned by UIKit-Methods, like... can't remember. Default value possible.

## Day 3 – operators and conditions

Just Keywords: *arithmetic operators, operator overloading, compound assignment operators, comparison operators, conditions, combining conditions, ternary operator, switch statements, range operators* 
## Day 4 – loops, loops, and more loops
*For, while, repeat*

Exit a loop with **break**. Exit multiple loops: Label the outside one and break it.
Skip with **continue**.

## Day 5 – functions, parameters, and errors

Interesting! Throwing function:
```swift
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```

## Day 6 – closures part one
I think I got them. Repeated this chapter a lot.
## Day 7 – closures part two
I think I got them. Repeated this chapter a lot.
## Day 8 – structs, properties, and methods
You know about structs, computed properties, property observers, methods, but do you remember this **mutating** keyword?

```swift
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
```

## Day 9 – access control, static properties, and laziness
If we add the **lazy** keyword, Swift will only create the property when it's first accessed. <br>
If we add the **static** keyword, Swift will share this property across all instances.
## Day 10 – classes and inheritance
Classes are the heart of OOP. Lost some importance with SwiftUI, I guess.

When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.
## Day 11 – protocols, extensions, and protocol extensions
Does SwiftUI do Protocol-oriented programming? Still trying to figure it out.
## Day 12 – optionals, unwrapping, and typecasting
Ok, that's heavily used in Swift. I know that.

## Day 13-15 - Consolidation