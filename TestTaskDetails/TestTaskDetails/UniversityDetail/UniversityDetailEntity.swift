import UIKit

public enum UniversityDetailEntity {

	public enum FetchDetails {
		public struct Request { }
		public struct Response {
			typealias UniversityDetail = ViewModel
			let detail: UniversityDetail
		}
		public struct ViewModel {
            let name: String
            let country: String
            let state: String
            let webpage: String

			public init(name: String, country: String, state: String, webpage: String) {
				self.name = name
				self.country = country
				self.state = state
				self.webpage = webpage
			}
        }
    }
}
