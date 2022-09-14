import Foundation

struct API {

    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request(url: URL, completionHandler: @escaping(Data?, Error?) -> Void) {
        session.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            completionHandler(data, error)
        }).resume()
    }

}
