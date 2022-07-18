//
//  UserCartTableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/16/22.
//

import UIKit

class UserCartTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProductImage: UIImageView!
    @IBOutlet weak var labelProductDesc: UILabel!
    @IBOutlet weak var labelProductUnitPrice: UILabel!
    @IBOutlet weak var labelFreeShipEligibility: UILabel!
    @IBOutlet weak var labelProductStockStatus: UILabel!
    @IBOutlet weak var labelProductCartQty: UILabel!
    @IBOutlet weak var buttonDecreaseCartQty: UIButton!
    
    var productID: Int64?
    var indexPathRowOfProduct: Int?
    
    let updateType_UpdateCartQty = [
        -1: "Decrease",
         0: "Delete",
         1: "Increase"
    ]
    
    @IBAction func buttonDeleteItemFromCart_TouchUpInside(_ sender: Any) {
        postNotification_UpdateCartQty(updateType: 0)
    }
    @IBAction func buttonDecreaseCartQty_TouchUpInside(_ sender: Any) {
        postNotification_UpdateCartQty(updateType: -1)
    }
    @IBAction func buttonIncreaseCartQty_TouchUpInside(_ sender: Any) {
        postNotification_UpdateCartQty(updateType: 1)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: PART 2 - CONFIGURE NOTIFICATION PUBLISHER TO UDPATE CART QTY
    func postNotification_UpdateCartQty(updateType: Int) {
        UserCartViewController.vc.productID_UpdateCartQty = self.productID
        UserCartViewController.vc.updateType_UpdateCartQty = updateType
        UserCartViewController.vc.indexPathRow_UpdateCartQty = self.indexPathRowOfProduct
        NotificationCenter.default.post(name: UserCartViewController.notification, object: nil)
    }

    //MARK: PART 1 - CONFIGURE CELL DATASOURCE WITH VIEWMODEL
    func configure(viewModel: UserCartViewModel) {
        self.productID = viewModel.productID
        self.indexPathRowOfProduct =  viewModel.indexPathRowOfProduct
        
        self.selectionStyle = .none
        
        self.imageProductImage.image = UIImage(named: viewModel.imageName)
        
        self.labelProductDesc.text = viewModel.productDesc
        
        self.labelProductUnitPrice.text = SharedServices.service.format_priceValFormatter(priceVal: viewModel.productUnitPrice, currency: "$", decimalPlaces: 2)
        
        self.labelFreeShipEligibility.text = viewModel.freeShipping ? "Eligible for FREE shipping" : ""
        
        let inStock: Bool = viewModel.productStockQty >= viewModel.productCartQty
        labelProductStockStatus.text = inStock ? "In stock" : "Out of stock"
        labelProductStockStatus.textColor = inStock ? .systemTeal : .red
        
        self.labelProductCartQty.text = "\(viewModel.productCartQty)"
        
        if viewModel.productCartQty == 1 {
            self.buttonDecreaseCartQty.setImage(UIImage(systemName: "trash"), for: .normal)
            self.buttonDecreaseCartQty.tintColor = .red
        } else {
            self.buttonDecreaseCartQty.setImage(UIImage(systemName: "minus.circle"), for: .normal)
            self.buttonDecreaseCartQty.tintColor = .systemYellow
        }
    }
}
