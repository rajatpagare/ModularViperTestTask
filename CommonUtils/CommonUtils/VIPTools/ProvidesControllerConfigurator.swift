import Foundation
import UIKit

public protocol ProvidesControllerConfigurator {
    associatedtype ControllerType: UIViewController

    static var configurator: AnyControllerConfigurator<ControllerType> { get }
}
