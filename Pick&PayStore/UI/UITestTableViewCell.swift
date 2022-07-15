//
//  UITestTableViewCell.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-03.
//

import UIKit

class UITestTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    var productID : Int64 = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with viewModel : TestProductsViewModel){
        self.productName.text = viewModel.name
        self.productPrice.text = String(viewModel.price)
        self.productImage.image = UIImage(named: viewModel.image)
        self.productID = viewModel.id
    }
    
    @IBAction func addToCart(_ sender: Any) {
        print("adding to cart")
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: productID, quantity: 1)
        postCartBannerNotification()
    }
    

}

//MARK: CART BANNER CONFIGURATION
extension UITestTableViewCell {
    func postCartBannerNotification() {
        UITestViewController.vc.productAtRow = productID
        NotificationCenter.default.post(name: UITestViewController.cartBannerNotification, object: nil)
    }
}
