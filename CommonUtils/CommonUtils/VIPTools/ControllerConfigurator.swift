import Foundation
import UIKit

public protocol ControllerConfigurator {
    associatedtype ControllerType: UIViewController

    func configure(_ target: ControllerType)

}

public struct AnyControllerConfigurator<ControllerType: UIViewController>: ControllerConfigurator {

    private let configureFn: (ControllerType) -> Void

    init<C: ControllerConfigurator>(_ configurator: C) where C.ControllerType == ControllerType {
        configureFn = configurator.configure
    }

	public func configure(_ target: ControllerType) {
        configureFn(target)
    }
}
