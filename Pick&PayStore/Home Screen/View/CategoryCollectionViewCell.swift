//
//  CategoryCollectionViewCell.swift
//  Pick&PayStore
//
//  Created by Owner on 2022-07-07.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    public func configure (with viewModel : HomeCategoryViewModel){
        self.categoryLabel.text = viewModel.name
        self.categoryImage.image = UIImage(named:viewModel.image)
        
    }
}
