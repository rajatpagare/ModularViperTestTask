import Foundation
import Alamofire

public class AlamofireNetwork: Network {
    private let baseURL: URL
    private let sessionManager: Session

	public init(baseURL: URL) {
        self.sessionManager = Session()
        self.baseURL = baseURL
    }

	public func doRequest(_ request: NetworkRequest) {
        performRequest(request)
    }

    private func performRequest(_ request: NetworkRequest, shouldRetry: Bool = true) {
        do {
            let urlRequest = try request.buildURLRequest(withBaseURL: baseURL)
            sessionManager.request(urlRequest).validate().response { response in
                if response.error != nil {
                    // It's a very ugly check to resolve an issue with some of the servers sending keep-alive header due to which we get error with simultaneously calling get/post methods
                    if response.description.contains("Code=-1005") && shouldRetry {
                        self.performRequest(request, shouldRetry: false)
                        return
                    }
                    if let code = response.response?.statusCode, let data = response.data {
                        request.handleError(.httpError(code: code, data: data))
                    } else {
                        request.handleError(.unknownError)
                    }
                    return
                }
                let dataResponse = AlamofireNetwork.responseFromData(response.data)
                do {
                    try request.handleResponse(dataResponse)
                } catch let error {
                    request.handleError(error as? NetworkError ?? .unknownError)
                }
            }
        } catch let error {
            request.handleError(error as? NetworkError ?? .unknownError)
        }
    }

    private static func responseFromData(_ data: Data?) -> NetworkResponse {
        guard let data = data, !data.isEmpty else {
            return .noData
        }
        return .data(data)
    }
}
