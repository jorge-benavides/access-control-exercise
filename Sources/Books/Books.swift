import Foundation
import API

public protocol BookRepositoryDelegate: AnyObject {
    func repositoryDidLoadBooks(_ books: [Book])
}

public class BookRepository {
    weak public var delegate: BookRepositoryDelegate?

    private let url = "https://raw.githubusercontent.com/wizeline/mock-api/main/bookstore/v1/books.json"
    private let decodeType = [Book].self
    private let api = API(session: .shared)

    public init() { }

    public func loadBooks() {
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

public struct Book: Decodable {
    public var id: String
    public var title: String
    public var description: String
    var cover: String
}
