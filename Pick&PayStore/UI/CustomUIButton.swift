//
//  CustomUIButton.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-28.
//

import UIKit

class YellowButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        YellowButton.appearance().tintColor = UIColor(named: "darkYellow")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

class GrayButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        GrayButton.appearance().tintColor = UIColor.lightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}


class LightBlueButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        LightBlueButton.appearance().tintColor = UIColor(named: "lightBlue")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}


