import UIKit
import CommonUtils

public class UniversityDetailsConfigurator: ControllerConfigurator {

	public init() {
		
	}
	public func configure(_ target: UniversityDetailViewController) {
		let interactor = UniversityDetailInteractor()
		let presenter = UniversityDetailPresenter()
		let router = UniversityDetailRouter()
		target.presenter = presenter
		presenter.router = router
		interactor.presenter = presenter
		presenter.display = target
		presenter.interactor = interactor
		router.viewController = target
		router.dataStore = interactor
		target.dataPassing = router
    }

}
