//
//  UniversitiesListCell.swift
//  TestTask
//
//  Created by Rajat Pagare on 09/05/24.
//

import UIKit
import CommonUtils

class UniversitiesListCell: UITableViewCell, Reusable {
	typealias ViewModel = UniversitiesListEntity.FetchUniversities.ViewModel.Details

	@IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func displayViewModel(_ viewModel: ViewModel) {
		nameLabel.text = viewModel.name
		stateLabel.text = viewModel.state
	}
}
