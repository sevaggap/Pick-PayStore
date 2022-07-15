//
//  ProductsListTableViewCell.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-14.
//

import UIKit

class ProductsListTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productStock: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(viewModel : ProductPageViewModel) {
        self.productName.text = viewModel.name
        self.productPrice.text = "$" + String(viewModel.price)
        self.productImage.image = UIImage(named: viewModel.image)
        
        if viewModel.quantity > 0 {
            self.productStock.text = "In Stock"
            self.productStock.textColor = .systemTeal
        } else {
            self.productStock.text = "Sold Out"
            self.productStock.textColor = .red
        }
    }

}
