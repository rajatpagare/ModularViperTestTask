import Foundation

struct UniversityDTO: Decodable {
	let state_province: String
	let domains: [String]
	let web_pages: [String]
	let name: String
	let alpha_two_code: String
	let country: String

	enum CodingKeys: String, CodingKey {
		case domains, web_pages, name, alpha_two_code, country
		case state_province = "state-province"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		state_province = (try? container.decode(String.self, forKey: .state_province)) ?? "N/A"
		domains = try container.decode([String].self, forKey: .domains)
		web_pages = try container.decode([String].self, forKey: .web_pages)
		name = try container.decode(String.self, forKey: .name)
		alpha_two_code = try container.decode(String.self, forKey: .alpha_two_code)
		country = try container.decode(String.self, forKey: .country)
	}
}


