import UIKit

// Challenge #3: The Library Challenge
//
// Instructions:
// Complete the class definition so that you get the expected output in the console (specified below the class definitions). See TODOs.
//

class Person {
    
    var name:String!
    
    init(_ fullName:String) {
        name = fullName
    }
}

class Book {
    
    var title:String!
    var author:String!
    
    init(_ bookTitle:String, _ bookAuthor:String) {
        title = bookTitle
        author = bookAuthor
    }
    
}

// --- Your code goes below this line ---

class Library {
    
    var catalogue = ["ORW":Book("1984", "George Orwell"),
                     "RAY":Book("Fahrenheit 451", "Ray Bradbury")]
    
    var checkedOutBooks = [String:Person]()
    
    func searchByTitle(_ title:String) -> String {
        guard let (bookId, _) = catalogue.first(where: { $1.title == title }) else { return "Not in catalogue" }
        guard let person = checkedOutBooks[bookId] else { return "Available" }
        
        return "Checked out by \(person.name!)"
    }
    
    func checkOut(_ bookId:String, _ person:Person) -> String {
        
        // TODO: This function adds to the checkedOutBooks dictionary
        //
        // Returns "Error: Book already checked out" if the book is already in the checkedOutBooks dictionary
        //
        // Returns "Successfully checked out" and adds the bookId,person key-value pair if the book doesn't currently exist in the checkedOutbooks dictionary
        //
        // Returns "Book doesn't exist" if the book isn't in the catalogue dictionary
        
        return ""
    }
    
    func checkIn(_ bookId:String) -> String {
        
        // TODO: This function removes the bookId,person key-value pair from the checkedOutBooks dictionary
        //
        // Returns "Book doesn't exist" if the book isn't in the catalogue dictionary
        //
        // Returns "Error: Can't check in a book that hasn't been checked out" if the book wasn't checked out in the first place
        //
        // Returns "Successfully checked in"
        
        
        
        return ""
    }
    
}
// --- Your code goes above this line ---

// --- Don't edit or add anything below this line ---

let lib = Library()
let borrower1 = Person("Curious George")
let borrower2 = Person("Mark Twain")

// George searches for a book
let searchResult = lib.searchByTitle("1984")
print(searchResult)

// Expected Output in console:
// "Available"

// George checks out the book
let borrowResult = lib.checkOut("ORW", borrower1)
print(borrowResult)

// Expected Output in console:
// "Successfully checked out"

// Mark searches for a book
let searchResult2 = lib.searchByTitle("1984")
print(searchResult2)

// Expected Output in console:
// "Checked out by Curious George"

// Mark tries to borrow a book that's already checked out
let borrowResult2 = lib.checkOut("ORW", borrower2)
print(borrowResult2)

// Expected Output in console:
// "Error: Book already checked out"

// A book is checked in
let checkInResult = lib.checkIn("RAY")
print(checkInResult)

// Expected Output in console:
// "Error: Can't check in a book that hasn't been checked out"

// George checks in his book
let checkInResult2 = lib.checkIn("ORW")
print(checkInResult2)

// Expected Output in console:
// "Successfully checked in"

// Mark attempts to borrow the book again
let borrowResult3 = lib.checkOut("ORW", borrower2)
print(borrowResult3)

// Expected Output in console:
// "Successfully checked out"
