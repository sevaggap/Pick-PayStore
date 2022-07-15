//
//  CustomUIView.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-28.
//

import UIKit

class CustomUIView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "lightBlue")!.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }

}

class ProductListView : UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "lightBlue")!.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
}
