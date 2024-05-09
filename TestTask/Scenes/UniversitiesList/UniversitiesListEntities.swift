//
//  UniversitiesListEntities.swift
//  TestTask
//
//  Created by Rajat Pagare on 08/05/24.
//

import Foundation

enum UniversitiesListEntity {
	enum FetchUniversities {
		struct Request { }
		struct Response {
			let universities: [University]
		}
		struct ViewModel {
			let universityDetails : [Details]
			struct Details {
				let identifier: String
				let name: String
				let state: String
			}
		}
	}
	
	enum Error {
		struct Request { }
		struct Response {
			let message: String
		}
		struct ViewModel {
			let message: String
		}
	}

	enum FetchSelectedUniversity {
		struct Request { }
		struct Response {
			typealias Identifier = String
			let identifier: Identifier
		}
		struct ViewModel { }
	}
}
