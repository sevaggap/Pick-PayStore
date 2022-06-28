//
//  CustomUIHeader.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-28.
//

import UIKit

class CustomUIHeader: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CustomUIHeader.appearance().font = UIFont(name: "Futura", size: 30)
    }

}
