//
//  UniversitiesListPresenter.swift
//  TestTask
//
//  Created by Rajat Pagare on 08/05/24.
//

import Foundation

protocol UniversitiesListPresentationLogic: AnyObject {
	func fetchUniversities()
	func presentUniversities(response: UniversitiesListEntity.FetchUniversities.Response)
	func presentError(response: UniversitiesListEntity.Error.Response)
	func presentUniversityDetails(response: UniversitiesListEntity.FetchSelectedUniversity.Response)
}

class UniversitiesListPresenter {
	var display: UniversitiesListDisplayLogic?
	var interactor: UniversitiesListBusinessLogic?
	var router: (NSObjectProtocol & UniversitiesListRoutingLogic)?
	private var universitiesResponse: UniversitiesListEntity.FetchUniversities.Response?
}

extension UniversitiesListPresenter: UniversitiesListPresentationLogic {
	func presentUniversityDetails(response: UniversitiesListEntity.FetchSelectedUniversity.Response) {
		guard let selectedUniversity = universitiesResponse?.universities.filter({ $0.identifier == response.identifier }) .first else { return }
		router?.routeToDetails(universityDetails: selectedUniversity)
	}
	
	func fetchUniversities() {
		interactor?.fetchUniversities(request: .init())
	}
	
	func presentUniversities(response: UniversitiesListEntity.FetchUniversities.Response) {
		universitiesResponse = response
		typealias Details = UniversitiesListEntity.FetchUniversities.ViewModel.Details
		let details = response.universities.map { universities in
			return Details(identifier: universities.identifier,
						   name: universities.name,
						   state: universities.stateProvince)
		}
		display?.displayUniversities(viewModel: .init(universityDetails: details))
	}
	
	func presentError(response: UniversitiesListEntity.Error.Response) {
		display?.displayError(viewModel: .init(message: response.message))
	}
}
