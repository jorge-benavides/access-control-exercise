import Foundation
import Books

open class App: BookRepositoryDelegate {
    
    private let repo = BookRepository()
    private var books: Array<Book> = []

    public init() {
        repo.delegate = self
        repo.loadBooks()
    }

    public func displayBooks() -> [Book] {
        return books
    }
    
    public func getBook(id: String) -> Book? {
        return books.first(where: { book in
            book.id == id
        })
    }

    open func repositoryDidLoadBooks(_ books: [Book]) {
        self.books = books
    }
}

