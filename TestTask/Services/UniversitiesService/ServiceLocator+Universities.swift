import Foundation
import CommonUtils

extension ServiceLocator {

    private func universitiesServiceKey() -> String {
        return String(describing: UniversitiesService.self)
    }

    func universitiesService() -> UniversitiesService {
        return service(forKey: universitiesServiceKey(),
					   orCreate: defaultUniversitiesService())
    }

    private func defaultUniversitiesService() -> UniversitiesService {
        let network = universitiesNetwork()
        return NetworkUniversitiesService(network: network)
    }

    private func universitiesNetworkKey() -> String {
        return String(describing: Network.self)
    }

    func universitiesNetwork() -> Network {
        return service(forKey: universitiesNetworkKey(),
					   orCreate: defaultUniversitiesNetwork())
    }

    private func defaultUniversitiesNetwork() -> Network {
        return AlamofireNetwork(baseURL: Environment.universitiesApiUrl)
    }
}
