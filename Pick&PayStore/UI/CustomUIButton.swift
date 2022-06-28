//
//  CustomUIButton.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-28.
//

import UIKit

class CustomUIButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CustomUIButton.appearance().tintColor = UIColor.lightGray
    }
    
}
