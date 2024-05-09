import UIKit

protocol UniversityDetailBusinessLogic {
    func fetchUniversityDetail(request: UniversityDetailEntity.FetchDetails.Request)
}

public protocol UniversityDetailDataStore {
	typealias UniversityDetail = UniversityDetailEntity.FetchDetails.ViewModel
    var details: UniversityDetail? { get set }
	var refreshHandler: (() -> Void)? { get set }
}

class UniversityDetailInteractor: UniversityDetailDataStore {
	typealias UniversityDetail = UniversityDetailEntity.FetchDetails.ViewModel
    var presenter: UniversityDetailPresentationLogic?
    var details: UniversityDetail?
	var refreshHandler: (() -> Void)?
}

extension UniversityDetailInteractor: UniversityDetailBusinessLogic {

	func fetchUniversityDetail(request: UniversityDetailEntity.FetchDetails.Request) {
        guard let details = details else { return }
		presenter?.presentUniversityDetail(response: .init(detail: details))
	}
}
