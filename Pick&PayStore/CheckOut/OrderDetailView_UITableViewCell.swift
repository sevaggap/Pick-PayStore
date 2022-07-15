//
//  OrderDetailView_UITableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/15/22.
//

import UIKit

class OrderDetailView_UITableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var labelItemCartQty: UILabel!
    @IBOutlet weak var labelItemPrice: UILabel!
    @IBOutlet weak var labelItemDesc: UILabel!
    @IBOutlet weak var imageItemImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
