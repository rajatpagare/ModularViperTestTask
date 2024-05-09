import Foundation
import UIKit

public protocol ControllerFactory {

    func newController<T, C: ControllerConfigurator>(configuredUsing configurator: C, instantiatedUsing instantiator: ControllerInstantiator) -> T where C.ControllerType == T

}

public extension ControllerFactory {

    func newController<T, C: ControllerConfigurator>(configuredUsing configurator: C, instantiatedUsing instantiator: ControllerInstantiator) -> T where C.ControllerType == T {
        let controller: T = instantiator.instantiate()
        configurator.configure(controller)
        return controller
    }

    func newController<T: ProvidesControllerInstantiator, C: ControllerConfigurator>(configuredUsing configurator: C) -> T where C.ControllerType == T {
        return newController(configuredUsing: configurator, instantiatedUsing: T.instantiator)
    }

    func newController<T: ProvidesControllerConfigurator>(instantiatedUsing instantiator: ControllerInstantiator) -> T where T.ControllerType == T {
        return newController(configuredUsing: T.configurator, instantiatedUsing: instantiator)
    }

    func newController<T: ProvidesControllerInstantiator & ProvidesControllerConfigurator>() -> T where T.ControllerType == T {
        return newController(configuredUsing: T.configurator, instantiatedUsing: T.instantiator)
    }

}
