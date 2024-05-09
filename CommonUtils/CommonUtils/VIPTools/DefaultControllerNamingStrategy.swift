import Foundation
import UIKit

public enum DefaultControllerNamingStrategy: ControllerNamingStrategy {
    case namedAfter(UIViewController.Type)
    case namedAfterWithoutViewControllerSuffix(UIViewController.Type)
    case namedExplicitly(String)

	public func name() -> String {
        switch self {
        case .namedAfter(let controllerType): return String(describing: controllerType)
        case .namedAfterWithoutViewControllerSuffix(let controllerType): return String(describing: controllerType).replacingOccurrences(of: "ViewController", with: "")
        case .namedExplicitly(let controllerName): return controllerName
        }
    }

}
