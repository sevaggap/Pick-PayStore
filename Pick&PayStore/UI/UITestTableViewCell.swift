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
    }

}
