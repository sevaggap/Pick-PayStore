//
//  OrderHistoryView_UITableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/14/22.
//

import UIKit

class OrderHistoryView_UITableViewCell: UITableViewCell {

    @IBOutlet weak var imageFirstItem: UIImageView!
    @IBOutlet weak var labelOrderDate: UILabel!
    @IBOutlet weak var labelOrderTenderType: UILabel!
    @IBOutlet weak var labelOrderTax: UILabel!
    @IBOutlet weak var labelOrderShippingFee: UILabel!
    @IBOutlet weak var labelOrderItemSubtotal: UILabel!
    @IBOutlet weak var labelOrderTotal: UILabel!
    @IBOutlet weak var labelOrderHID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
