import Foundation

protocol UniversitiesService {
    typealias UniversitiesCallback = (Result<[University], UniversitiesServiceError>) -> Void
    func getUniversities(country: String, completion: @escaping UniversitiesCallback)
}

enum UniversitiesServiceError: Error {
    case other(Error)
}
