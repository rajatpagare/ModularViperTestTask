//
//  UniversitiesListRouter.swift
//  TestTask
//
//  Created by Rajat Pagare on 08/05/24.
//

import Foundation
import TestTaskDetails
import CommonUtils

protocol UniversitiesListRoutingLogic {
	func routeToDetails(universityDetails: University)
}

class UniversitiesListRouter: NSObject {
	weak var viewController: UniversitiesListView?
}

extension UniversitiesListRouter: UniversitiesListRoutingLogic {
	func routeToDetails(universityDetails: University) {
		let vc = DefaultControllerFactory().newController(configuredUsing: UniversityDetailsConfigurator())
		var targetDS = vc.dataPassing?.dataStore
		targetDS?.details = UniversityDetailEntity.FetchDetails.ViewModel(name: universityDetails.name,
																		  country: universityDetails.country,
																		  state: universityDetails.stateProvince,
																		  webpage: universityDetails.webPages.first ?? "")
		targetDS?.refreshHandler = { [weak self] in
			self?.viewController?.presenter?.fetchUniversities()
		}
		viewController?.navigationController?.pushViewController(vc, animated: true)
	}
}
