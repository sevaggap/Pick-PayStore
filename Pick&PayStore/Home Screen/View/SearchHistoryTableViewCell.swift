//
//  SearchHistoryTableViewCell.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-19.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var searchHistory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
