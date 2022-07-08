//
//  DetailCVC.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-05.
//

import UIKit

class DetailCVC: UICollectionViewCell
{
    
    
    @IBOutlet weak var ProductImage: UIImageView!
    
    
    override func layoutSubviews()
    {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
