//: Playground - noun: a place where people can play

import UIKit

//: Recap
//: Library exercise with classes, and functions

//: Protocol

protocol OtherProtocol {
    
}

protocol RandomNumberGenerator {
    
    var lastRandomNumber: Double { get }
    
    func random() -> Double
    
    mutating func changeSomething()
}

class Game: RandomNumberGenerator, OtherProtocol {
    
    var lastRandomNumber: Double = 0.0
    
    func random() -> Double {
        
        // Generate random number
        
        return 0.0
    }
    
    func changeSomething() {
        
        // Change an attribute
    }
}

//: Delegation

protocol DiceGame {
    
    func play()
}

protocol DiceGameDelegate: class {
    
    func didStartGame(_ game: DiceGame)
    func didEndGame(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    
    weak var delegate: DiceGameDelegate?
    
    func play() {
        
        delegate?.didStartGame(self)
        
        // Play game
        
        delegate?.didEndGame(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    
    var snakesAndLadders: SnakesAndLadders?
    
    init() {
        
        snakesAndLadders?.delegate = self
    }
    
    func didStartGame(_ game: DiceGame) {
        
        // update UI when game starts
    }
    
    func didEndGame(_ game: DiceGame) {
        
        // update UI when game ends
    }
}

class Book {
    
    private var pages = [Page]()
    
    func add(_ page : Page) {
        pages.append(page)
    }
}

class Page {
    
    private var book : Book
    
    required init(book : Book) {
        self.book = book
    }
}

