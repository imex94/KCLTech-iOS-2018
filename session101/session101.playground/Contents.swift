//: Playground - noun: a place where people can play

import UIKit

print("Hello, KCL Tech")

//: Variables

let string = "Hello"
let number = 5

let 🐶🐮 = "dogcow"
let 𝛑 = Double.pi

//: Combining String and Characters

let dog = "dog"
let cow = "cow"
let dogCow = dog + cow

//: Building Complex Strings

let a = 3
let b = 5

let result = "\(a) times \(b) is \(a*b)"

//: String Mutability

var variableString = "Horse"
variableString += " and carriage"

//: Array and Dictionary

let names = ["Anna", "Brian", "Jack"]
let numberOfLegs = ["ant": 6, "snake": 0]

//: Loops

for (animal, leg) in numberOfLegs {
    print("\(animal)s have \(leg) legs")
}

//: Control Flows

let legCount = numberOfLegs.first?.value

if legCount == 0 {
    
    print("It slides")
    
} else if legCount == 1 {
    
    print("It hops")
    
} else {
    
    print("It walks")
}

switch legCount! {
case 0:
    print("It slides")
case 1,3,5,7,9:
    print("It hops")
case 2,4,6,8:
    print("It walks")
default:
    print("No idea")
}

//: Functions

func sayHello(to name: String) {
    print("Hello \(name)!")
}

sayHello(to: "Alex")

func say(_ name: String) -> String {
    return "Hello \(name)!"
}

print(say("Alex"))

