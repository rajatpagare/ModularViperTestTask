//
//  UniversitiesListInteractor.swift
//  TestTask
//
//  Created by Rajat Pagare on 08/05/24.
//

import Foundation
import CommonUtils

protocol UniversitiesListBusinessLogic: AnyObject {
	func fetchUniversities(request: UniversitiesListEntity.FetchUniversities.Request)
}

class UniversitiesListInteractor {
	weak var presenter: UniversitiesListPresentationLogic?
	let universitiesService = ServiceLocator.shared.universitiesService()
	private let selectedCountry = "United Arab Emirates"
	private let realmUniversityStore = RealmUniversityStore()

	private func persistUniversities(universities: [University]) {
		realmUniversityStore.deleteAllObjects()
		for university in universities {
			let realmUniversity = RealmUniversity()
			realmUniversity.stateProvince = university.stateProvince
			for domain in university.domains {
				realmUniversity.domains.append(domain)
			}
			for webPage in university.webPages {
				realmUniversity.webPages.append(webPage)
			}
			realmUniversity.name = university.name
			realmUniversity.code = university.code
			realmUniversity.country = university.country
			realmUniversity.identifier = university.identifier
			realmUniversityStore.saveUniversity(realmUniversity)
		}
	}

	private func getAllPersistedUniversities() -> [University] {
		let realmUniversities = realmUniversityStore.getAllUniversities()
		let universities = realmUniversities.map { university in
			return University(stateProvince: university.stateProvince,
							  domains: Array(university.domains),
							  webPages: Array(university.webPages),
							  name: university.name,
							  code: university.code,
							  country: university.country,
							  identifier: university.identifier)
		}
		return universities
	}
}

extension UniversitiesListInteractor: UniversitiesListBusinessLogic {
	func fetchUniversities(request: UniversitiesListEntity.FetchUniversities.Request) {
		if Reachability.isConnectedToNetwork() {
			universitiesService.getUniversities(country: selectedCountry) { [weak self] result in
				guard let self = self else { return }
				switch result {
				case .success(let universities):
					self.persistUniversities(universities: universities)
					self.presenter?.presentUniversities(response: .init(universities: universities))
				case .failure(let error):
					let universities = self.getAllPersistedUniversities()
					if universities.isEmpty {
						self.presenter?.presentError(response: .init(message: error.localizedDescription))
					} else {
						self.presenter?.presentUniversities(response: .init(universities: universities))
					}
				}
			}
		} else {
			let universities = self.getAllPersistedUniversities()
			if universities.isEmpty {
				presenter?.presentError(response: .init(message: "No network available!!!"))
			} else {
				self.presenter?.presentUniversities(response: .init(universities: universities))
			}
		}
	}
}
