import Foundation

public class ServiceLocator {
	public static let shared = ServiceLocator()

    private var services: [String: Any] = [:]
	public func registerService<T>(_ service: T, forKey key: String) {
        services[key] = service
    }

	public func service<T>(forKey key: String) -> T {
        // swiftlint:disable force_cast
        return services[key] as! T
        // swiftlint:enable force_cast
    }

	public func service<T>(forKey key: String, orCreate creator: @autoclosure () -> T) -> T {
        guard let value = services[key] as? T else {
            let created = creator()
            services[key] = created
            return created
        }
        return value
    }
}
