//
//  UniversitiesListView.swift
//  TestTask
//
//  Created by Rajat Pagare on 08/05/24.
//

import UIKit
import CommonUtils

protocol UniversitiesListDisplayLogic: AnyObject {
	func displayUniversities(viewModel: UniversitiesListEntity.FetchUniversities.ViewModel)
	func displayError(viewModel: UniversitiesListEntity.Error.ViewModel)
}

class UniversitiesListView: UIViewController {
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	var presenter: UniversitiesListPresentationLogic?
	private var universityDetails: [UniversitiesListEntity.FetchUniversities.ViewModel.Details] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		UniversitiesListConfigurator().configure(self)
		presenter?.fetchUniversities()
	}
}

extension UniversitiesListView: UniversitiesListDisplayLogic {
	func displayUniversities(viewModel: UniversitiesListEntity.FetchUniversities.ViewModel) {
		errorLabel.isHidden = true
		tableView.isHidden = false
		universityDetails = viewModel.universityDetails
		tableView.reloadData()
	}

	func displayError(viewModel: UniversitiesListEntity.Error.ViewModel) {
		errorLabel.isHidden = false
		tableView.isHidden = true
		errorLabel.text = viewModel.message
	}
}

extension UniversitiesListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		universityDetails.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UniversitiesListCell.self)
		let details = universityDetails[indexPath.row]
		cell.displayViewModel(details)
		cell.accessoryType = .disclosureIndicator
		return cell
	}
}

extension UniversitiesListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let selectedUniversity = universityDetails[safe: indexPath.row] else { return }
		presenter?.presentUniversityDetails(response: .init(identifier: selectedUniversity.identifier))
	}
}
