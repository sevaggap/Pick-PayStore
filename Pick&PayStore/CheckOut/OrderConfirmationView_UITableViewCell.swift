//
//  OrderConfirmationView_UITableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/8/22.
//

import UIKit

class OrderConfirmationView_UITableViewCell: UITableViewCell {

    @IBOutlet weak var labelItemQty: UILabel!
    @IBOutlet weak var labelItemSubtotal: UILabel!
    @IBOutlet weak var labelItemDesc: UILabel!
    @IBOutlet weak var imageItemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
