import Foundation
import CommonUtils

struct NetworkUniversitiesService: UniversitiesService {

    let network: Network
    
	func getUniversities(country: String,
						 completion: @escaping UniversitiesCallback) {
		let request = UniversitiesAPI.getUniversities(country: country) {
            self.onResult($0, completion: completion)
        }
        network.doRequest(request)
    }

    private func onResult(_ result: Result<[UniversityDTO], NetworkError>, completion: @escaping UniversitiesCallback) {
        switch result {
        case .success(let universityDTO):
            let universities = universityDTO.compactMap { University($0) }
            completion(.success(universities))
        case .failure(let error):
            completion(.failure(.other(error)))
        }
    }
}
