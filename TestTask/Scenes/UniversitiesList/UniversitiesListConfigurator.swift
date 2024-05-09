//
//  UniversitiesListConfigurator.swift
//  TestTask
//
//  Created by Rajat Pagare on 08/05/24.
//

import Foundation
import CommonUtils

class UniversitiesListConfigurator: ControllerConfigurator {

	func configure(_ target: UniversitiesListView) {
		let interactor = UniversitiesListInteractor()
		let presenter = UniversitiesListPresenter()
		let router = UniversitiesListRouter()
		target.presenter = presenter
		presenter.router = router
		interactor.presenter = presenter
		presenter.display = target
		presenter.interactor = interactor
		router.viewController = target
	}

}
