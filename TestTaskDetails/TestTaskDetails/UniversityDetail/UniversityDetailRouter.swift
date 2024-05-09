import UIKit
import MessageUI

public protocol UniversityDetailRoutingLogic { 
	func refreshAndPopController()
}

public protocol UniversityDetailDataPassing {
    var dataStore: UniversityDetailDataStore? { get }
}

public class UniversityDetailRouter: NSObject, UniversityDetailDataPassing {
    weak var viewController: UniversityDetailViewController?
	public var dataStore: UniversityDetailDataStore?
}

extension UniversityDetailRouter: UniversityDetailRoutingLogic {
	public func refreshAndPopController() {
		if let handler = dataStore?.refreshHandler {
			handler()
		}
		viewController?.navigationController?.popViewController(animated: true)
	}
}
