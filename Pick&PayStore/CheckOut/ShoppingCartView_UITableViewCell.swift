//
//  ShoppingCartView_UITableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 6/30/22.
//

import UIKit

protocol ShoppingCartView_UITableViewCellDelegate: AnyObject {
    func buttonDidTouchUpInside(buttonType: Int, currentRow: Int)
}
let ShoppingCartTableViewButtonType: [Int: String] = [0: "increaseQty", 1: "decreaseQty", 2: "deleteItem"]

class ShoppingCartView_UITableViewCell: UITableViewCell {

    
    private var currentRow = 0
    func configRow(currentRow: Int) {
        self.currentRow = currentRow
    }
    
    
    weak var delegate: ShoppingCartView_UITableViewCellDelegate?
    @IBOutlet weak var buttonDecreaseQtyOutlet: UIButton!
    @IBAction func buttonDecreaseQty(_ sender: Any) {
        delegate?.buttonDidTouchUpInside(buttonType: 1, currentRow: self.currentRow)
    }
    @IBAction func buttonIncreaseQty(_ sender: Any) {
        delegate?.buttonDidTouchUpInside(buttonType: 0, currentRow: self.currentRow)
    }
    @IBAction func buttonDeleteItem(_ sender: Any) {
        delegate?.buttonDidTouchUpInside(buttonType: 2, currentRow: self.currentRow)
    }
    @IBOutlet weak var labelCartDetailCartQty: UILabel!
    @IBOutlet weak var labelCartDetailInStock: UILabel!
    @IBOutlet weak var labelCartDetailFreeShipping: UILabel!
    @IBOutlet weak var labelCartDetailPrice: UILabel!
    @IBOutlet weak var labelCartDetailDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
