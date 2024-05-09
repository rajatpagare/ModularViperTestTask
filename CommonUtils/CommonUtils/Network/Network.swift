import Foundation

public enum HTTPMethod: String, Decodable {
    case post, get, delete, put, patch
}

public enum ContentType: Equatable {
    case json
    case urlEncoded
    case custom(String)
    case none

    func setContentHeader(urlRequest: inout URLRequest) {
        switch self {
        case .json:
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        case .urlEncoded:
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        case .custom(let value):
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue(value, forHTTPHeaderField: "Content-Type")
            }
        default:
            break
        }
    }
}

public protocol NetworkRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var contentType: ContentType { get }
    var acceptHeaderValue: String? { get }

    func handleResponse(_ response: NetworkResponse) throws
    func handleError(_ error: NetworkError)
    func buildURLRequest(withBaseURL baseURL: URL) throws -> URLRequest
}

public extension NetworkRequest {

    var queryItems: [URLQueryItem]? { return nil }
    var body: Data? { return nil }
    var contentType: ContentType { return .none }
    var acceptHeaderValue: String? { return nil }

}

public enum NetworkResponse {
    case data(Data)
    case noData
}

public extension NetworkRequest {

    func buildURLRequest(withBaseURL baseURL: URL) throws -> URLRequest {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        if !(queryItems?.isEmpty ?? true) {
            components.queryItems = queryItems
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        guard let componentURL = components.url else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: componentURL)
        urlRequest.httpMethod = method.rawValue.uppercased()
        urlRequest.httpBody = body
        contentType.setContentHeader(urlRequest: &urlRequest)
        setAcceptHeader(urlRequest: &urlRequest, acceptHeaderValue: acceptHeaderValue)
        return urlRequest
    }

    func setAcceptHeader(urlRequest: inout URLRequest, acceptHeaderValue: String?) {
        if let value = acceptHeaderValue {
            urlRequest.setValue(value, forHTTPHeaderField: "Accept")
        }
    }

}

public protocol Network {
    func doRequest(_ request: NetworkRequest)
}

public enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case invalidRequest(description: String)
    case httpError(code: Int, data: Data)
    case tokenExpired
    case tokenMissing
    case unknownError
}
