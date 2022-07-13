//
//  OrderView_UITableViewCellShipping.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/3/22.
//

import UIKit

class OrderView_UITableViewCellShipping: UITableViewCell {

    @IBOutlet weak var labelShippingAddressFieldRequired: UILabel!
    @IBOutlet weak var textFieldShippingAddressField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
