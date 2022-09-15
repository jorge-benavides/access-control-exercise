import Foundation

public struct API {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func request(url: URL, completionHandler: @escaping(Data?, Error?) -> Void) {
        session.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            completionHandler(data, error)
        }).resume()
    }

}
