import UIKit
import CommonUtils

protocol UniversityDetailDisplayLogic: AnyObject {
    func displayUniversityDetail(viewModel: UniversityDetailEntity.FetchDetails.ViewModel)
}

public class UniversityDetailViewController: UIViewController {

	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var webpageLabel: UILabel!
	@IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	
	public var presenter: UniversityDetailPresentationLogic?
	public var dataPassing: (NSObjectProtocol & UniversityDetailRoutingLogic & UniversityDetailDataPassing)?

	public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.2.circlepath.circle.fill"), style: .plain, target: self, action: #selector(refreshTapped))
		presenter?.fetchUniversityDetail()
    }

	public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

	@objc private func refreshTapped(sender: UIBarButtonItem) {
		presenter?.refreshTapped()
	}
}

extension UniversityDetailViewController: UniversityDetailDisplayLogic {
	func displayUniversityDetail(viewModel: UniversityDetailEntity.FetchDetails.ViewModel) {
        nameLabel.text = viewModel.name
        webpageLabel.text = viewModel.webpage
        stateLabel.text = viewModel.state
        countryLabel.text = viewModel.country
    }
}

extension UniversityDetailViewController: ProvidesControllerInstantiator {
	public static var instantiator: ControllerInstantiator = DefaultControllerInstantiator.storyboard(DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(UniversityDetailViewController.self))
}
