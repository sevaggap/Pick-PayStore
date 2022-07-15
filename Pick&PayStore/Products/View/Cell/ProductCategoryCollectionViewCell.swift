//
//  CategoryCollectionViewCell.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-14.
//

import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    public func configure(viewModel : CategoryPageViewModel) {
        self.categoryName.text = viewModel.name
        self.categoryImage.image = UIImage(named: viewModel.image)
    }
}
