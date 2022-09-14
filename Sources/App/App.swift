import Foundation
import Books

class App: BookRepositoryDelegate {
    
    let repo = BookRepository()
    var books: Array<Book> = []

    init() {
        repo.delegate = self
        repo.loadBooks()
    }

    func displayBooks() -> [Book] {
        return books
    }
    
    func getBook(id: String) -> Book? {
        return books.first(where: { book in
            book.id == id
        })
    }

    func repositoryDidLoadBooks(_ books: [Book]) {
        self.books = books
    }
}

