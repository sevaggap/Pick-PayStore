//
//  PaymentMethodView_UITableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/1/22.
//

import UIKit

class PaymentMethodView_UITableViewCell: UITableViewCell {

    @IBOutlet weak var imageTenderTypeImg: UIImageView!
    @IBOutlet weak var labelTenderTypeDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
