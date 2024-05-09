import Foundation
import CommonUtils

enum UniversitiesAPI: NetworkRequest {

    typealias UniversitiesCallback = (Result<[UniversityDTO], NetworkError>) -> Void
	case getUniversities(country: String, callback: UniversitiesCallback)

    var path: String {
        switch self {
        case .getUniversities: return "/search"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUniversities: return .get
        }
    }

    func handleResponse(_ response: NetworkResponse) throws {
        switch (self, response) {
        case (.getUniversities(_, let callback), .data(let data)):
            do {
                let decoder = JSONDecoder()
                let dto = try decoder.decode([UniversityDTO].self, from: data)
                callback(.success(dto))
            } catch {
                print(error.localizedDescription)
            }
        default:
            throw NetworkError.invalidResponse
        }
    }

    func handleError(_ error: NetworkError) {
        switch self {
        case .getUniversities(_, let callback):
            callback(.failure(error))
        }
    }

    var contentType: ContentType {
        switch self {
        case .getUniversities:
            return .json
        }
    }

	var queryItems: [URLQueryItem]? {
		switch self {
		case .getUniversities(let country, _):
			return [URLQueryItem(name: "country", value: country)]
		}
	}
}
