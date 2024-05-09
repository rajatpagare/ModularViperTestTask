import Foundation

struct Environment {
    static private let infoDictionary = Bundle.main.infoDictionary!

    static var universitiesApiUrl: URL {
        return URL(string: url(forKey: "Universities API URL"))!
    }

    static func url(forKey key: String) -> String {
        guard let url = (infoDictionary[key] as? String)?.replacingOccurrences(of: "\\", with: "") else {
            assertionFailure("Missing URL from plist!")
            return ""
        }
        return url
    }
}
