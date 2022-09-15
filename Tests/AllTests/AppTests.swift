import XCTest
import App
//@testable import App
import Books

class AppTest: App {
    var expectation: XCTestExpectation?
    init(_ expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
        super.init()
    }

    override func repositoryDidLoadBooks(_ books: [Book]) {
        super.repositoryDidLoadBooks(books)
        expectation?.fulfill()
    }
}

final class AppTests: XCTestCase {


    func testApp() throws {
        let app = AppTest(self.expectation(description: "App to load books"))
        waitForExpectations(timeout: 8)

        let books = app.displayBooks()

        XCTAssertGreaterThan(books.count, 0)
    }

    func testAppBook() throws {
        let app = AppTest(self.expectation(description: "App to load books"))
        waitForExpectations(timeout: 8)

        let book = app.getBook(id: "08F2D11D-2AD6-40A2-8C5E-B31F133109DE")

        XCTAssertNotNil(book)
    }

    func testAppBookInfo() throws {
        let app = AppTest(self.expectation(description: "App to load books"))
        waitForExpectations(timeout: 8)

        let book = app.getBook(id: "08F2D11D-2AD6-40A2-8C5E-B31F133109DE")
        let title = book?.title
        let description = book?.description

        XCTAssertEqual(title, "The Two Towers")
        XCTAssertEqual(description, "The Two Towers opens with the disintegration of the Fellowship, as Merry and Pippin are taken captive by Orcs after the death of Boromir in battle. The Orcs, having heard a prophecy that a Hobbit will bear a Ring that gives universal power to its owner, wrongly think that Merry and Pippin are the Ring-bearers.")
    }
}
