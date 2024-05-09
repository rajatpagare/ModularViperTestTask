import Foundation

public struct University {
    let stateProvince: String
    let domains: [String]
    let webPages: [String]
    let name: String
    let code: String
    let country: String
	let identifier: String
}

extension University {
    init(_ from: UniversityDTO) {
		stateProvince = from.state_province
        name = from.name
		domains = from.domains
		webPages = from.web_pages
		code = from.alpha_two_code
		country = from.country
		identifier = UUID().uuidString
    }
}
