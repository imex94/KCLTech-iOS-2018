//: Playground - noun: a place where people can play

import UIKit

//: Playground - noun: a place where people can play

import UIKit

// ---------- SESSION 2

//: Recap Quiz

//  Create a constant dictionary which contains a list of animals. The Animals are Dog, Cat, Snake, Kangaroos and Bunny. The dictionary should hold how each animal moves; Dogs and cats walk, snakes slide, kangaroos and bunny hop. Go through your dictionary, check how each animal moves and print out the name and type of movement of each one of them.

let animalsDictionary = [
    "Dog":"walk",
    "Cat":"walk",
    "Snake":"slide",
    "Kangoroos":"hop",
    "Bunny":"hop"
]

for (animal, move) in animalsDictionary {
    print("\(animal) \(move)s")
}
















let animals = ["Dog":"walk","Cat":"walk","Snake":"slide","Kangaroo":"hop", "Bunny":"hop"]

for (animal,movement) in animals {
    
    if (movement == "walk") {
        print("\(animal) movement type is walking")
        
    } else if (movement == "slide") {
        print("\(animal) movement type is sliding")
        
    } else if (movement == "hop") {
        print("\(animal) movement type is hopping")
    }
}

//: Tuples

let http404Error = (404, "Not Found")

//Student detail (name,year,age,present)

let mahyad = ("Mahyad",2,25,true)

//Access Values

print("The student's name is:\t \(mahyad.0)")
print("The student's year of study is:\t \(mahyad.1)")
print("The student's age is:\t \(mahyad.2)")
print("The student is present:\t \(mahyad.3)\n")

//Naming individual element

let alex = (name: "Alex", year: 4, age: 23, present: true)

print("The student's name is:\t \(alex.name)")
print("The student's year of study is:\t \(alex.year)")
print("The student's age is:\t \(alex.age)")
print("The student is present:\t \(alex.present)\n")

//: Optionals

var serverResponceCode: Int?

if serverResponceCode != nil {
    print("The responce from the server was:\t \(serverResponceCode!)")
} else {
    print("No responce from the server")
}

serverResponceCode = 404

if serverResponceCode != nil {
    print("The responce from the server was:\t \(serverResponceCode!)")
} else {
    print("No responce from the server")
}


//Optional Binding

if let responce = serverResponceCode {
    print("The responce from the server was:\t \(responce)")
}

//Implicit unwrapping
var assumedserverResponceCode:Int! = 404

//Optional Chaining

var numberOfLegs = ["ant": 6, "snake": 0]

let legCount = numberOfLegs.first?.value

//: Functions

//func nameOfFunction(outterParameterName innerParameterName: Type) -> returnType {
//    //where your code goes
//}

func incrementByOne (value: Int = 5) {
    print("\(value+1)")
}

incrementByOne(value: 2)
incrementByOne()

func sayHello(to name: String) {
    print("Hello \(name)!")
}

sayHello(to: "Mahyad")

func sayHello(_ name: String) {
    print("Hello \(name)!")
}

sayHello(_: "Everyone")

func addition (value1: Int, value2: Int) -> Int {
    
    return value1 + value2
}

print("The sum of 10 and 9 is:\t \(addition(value1: 10, value2: 9))")

//:Closures

// { (parameter) -> (return type) in
//  statement
//  }

var letters = ["1", "2", "3", "4", "5"]

// 1
func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

letters.sorted(by: backwards)

// 2
letters.sort { (s1: String, s2: String) -> Bool in
    return s1 > s2
}

// 3
letters.sort { s1, s2 in return s1 > s2 }

// 4
letters.sort { $0 > $1 }

// 5
letters.sorted(by: >)

//: Enum

enum carType {
    case Muscle
    case Electric
    case Hybrid
}

let car = carType.Electric


//switch statement

switch car {
    
case carType.Muscle:
    print("maybe compensating for something")
    
case carType.Electric:
    print("Hypsters choice of weapon")
    
case carType.Hybrid:
    print("is it a Hybrid? please don't stop talking how you're saving the world, please continue...")
    
}

//if statements

if car == .Muscle {
    print("maybe compensating for something")
    
} else if car == .Electric {
    print("Hypsters choice of weapon")
    
} else if car == .Hybrid {
    print("is it a Hybrid? please don't stop talking how you're saving the world, please continue...")
    
} else {
    print("model not recognized")
    
}

//: Class and Structures

//class
//class Person {
//
//    let name:String?
//    var age:Int?
//    var height:Double?
//    var gender:String?
//
//    init(name: String, age: Int, height: Double, gender: String) {
//
//        self.name = name
//        self.age = age
//        self.height = height
//        self.gender = gender
//    }
//
//    func getName() -> String {
//
//        return name!
//    }
//
//    func setAge (age: Int) {
//
//        self.age = age
//    }
//
//    func setHeight (height: Double) {
//
//        self.height = height
//    }
//
//}

struct Person {

    let name:String?
    var age:Int?
    var height:Double?
    var gender:String?
}


var mahyad = Person(name: "Mahyad", age: 0, height: 0, gender: "Male")

mahyad.age = 25
mahyad.height = 180.0

print("my name is \(mahyad.name!)")


// main difference

class SomeClass {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var aClass = SomeClass(name: "Bob")
var bClass = aClass // aClass and bClass now reference the same instance!
bClass.name = "Sue"

print(aClass.name) // "Sue"
print(bClass.name) // "Sue"

struct SomeStruct {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var aStruct = SomeStruct(name: "Bob")
var bStruct = aStruct // aStruct and bStruct are two structs with the same value!
bStruct.name = "Sue"

print(aStruct.name)
print(bStruct.name)

