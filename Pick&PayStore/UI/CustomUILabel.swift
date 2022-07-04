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
        CustomUIHeader.appearance().font = UIFont(name: "Damascus", size: 24)
        CustomUIHeader.appearance().textColor = .black
        CustomUIHeader.appearance().textAlignment = .center
    }
    
}

class PromoLabel : UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        PromoLabel.appearance().font = UIFont(name: "Damascus", size: 22)
        PromoLabel.appearance().textAlignment = .center
        PromoLabel.appearance().textColor = .black
    }
}

class CustomAccountLabel : UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CustomAccountLabel.appearance().font = UIFont(name: "System", size: 14)
        CustomAccountLabel.appearance().textColor = .black
        CustomAccountLabel.appearance().textAlignment = .center
    }

}

class HomeCategoryLabel : UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        HomeCategoryLabel.appearance().font = UIFont(name: "Damascus", size: 15)
        HomeCategoryLabel.appearance().textColor = .black
    }
}
