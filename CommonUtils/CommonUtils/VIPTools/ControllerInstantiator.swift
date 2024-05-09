import Foundation
import UIKit

public protocol ControllerInstantiator {

    func instantiate<T: UIViewController>() -> T

}
