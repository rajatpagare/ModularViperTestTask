import Foundation

public protocol ProvidesControllerInstantiator {
	static var instantiator: ControllerInstantiator { get }
}

protocol InstantiatedWithMatchingNibName: ProvidesControllerInstantiator { }

protocol InstantiatedWithoutViewControllerSuffixStoryboardName: ProvidesControllerInstantiator { }
