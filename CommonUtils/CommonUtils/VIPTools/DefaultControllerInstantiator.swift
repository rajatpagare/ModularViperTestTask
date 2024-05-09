import Foundation
import UIKit

public enum DefaultControllerInstantiator: ControllerInstantiator {
    case nib(ControllerNamingStrategy)
    case storyboard(ControllerNamingStrategy)

	public func instantiate<T: UIViewController>() -> T {
        let bundle = Bundle(for: T.self)
        switch self {
        case .storyboard(let strategy):
            guard let vc = UIStoryboard(name: strategy.name(), bundle: bundle).instantiateInitialViewController() as? T else {
                fatalError("Expected to have a initialViewController of \(String(describing: T.self)) in storyboard \(strategy.name())")
            }
            return vc
        case .nib(let strategy): return T(nibName: strategy.name(), bundle: bundle)
        }
    }
}

extension InstantiatedWithMatchingNibName where Self: UIViewController {

    static var instantiator: ControllerInstantiator {
        return DefaultControllerInstantiator.nib(DefaultControllerNamingStrategy.namedAfter(Self.self))
    }

}

extension InstantiatedWithoutViewControllerSuffixStoryboardName where Self: UIViewController {

    static var instantiator: ControllerInstantiator {
        return DefaultControllerInstantiator.storyboard(DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(Self.self))
    }

}
