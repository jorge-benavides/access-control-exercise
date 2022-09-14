import Foundation
import API

protocol BookRepositoryDelegate: AnyObject {
    func repositoryDidLoadBooks(_ books: [Book])
}

class BookRepository {
    weak var delegate: BookRepositoryDelegate?

    let url = "https://raw.githubusercontent.com/wizeline/mock-api/main/bookstore/v1/books.json"
    let decodeType = [Book].self
    let api = API(session: .shared)

    init() { }

    func loadBooks() {
        guard let url = URL(string: url) else { return }
        api.request(url: url) { [weak delegate] (data: Data?, error: Error?) in
            let books: [Book]
            if let data = data {
                books = (try? JSONDecoder().decode(self.decodeType, from: data)) ?? []
            } else {
                books = []
            }
            delegate?.repositoryDidLoadBooks(books)
        }
    }
}

struct Book: Decodable {
    var id: String
    var title: String
    var description: String
    var cover: String
}
