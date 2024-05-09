import UIKit

public protocol UniversityDetailPresentationLogic {
	func fetchUniversityDetail()
    func presentUniversityDetail(response: UniversityDetailEntity.FetchDetails.Response)
	func refreshTapped()
}

class UniversityDetailPresenter {
	var display: UniversityDetailDisplayLogic?
	var interactor: UniversityDetailBusinessLogic?
	var router: (NSObjectProtocol & UniversityDetailRoutingLogic & UniversityDetailDataPassing)?
}

extension UniversityDetailPresenter: UniversityDetailPresentationLogic {

	func presentUniversityDetail(response: UniversityDetailEntity.FetchDetails.Response) {
		display?.displayUniversityDetail(viewModel: .init(name: response.detail.name,
														  country: response.detail.country,
														  state: response.detail.state,
														  webpage: response.detail.webpage))

    }

	func fetchUniversityDetail() {
		interactor?.fetchUniversityDetail(request: .init())
	}

	func refreshTapped() {
		router?.refreshAndPopController()
	}
}
