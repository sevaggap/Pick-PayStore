//
//  SubTVC.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-08.
//

import UIKit

class SubTVC: UITableViewCell {

    @IBOutlet weak var tableListImage: UIImageView!
    @IBOutlet weak var tableListLabel: UILabel!
    @IBOutlet weak var tableListPrice: UILabel!
    @IBOutlet weak var tableListQty: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
