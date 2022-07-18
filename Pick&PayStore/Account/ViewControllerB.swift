//
//  ViewControllerB.swift
//  Pick&PayStore
//
//  Created by MAC on 2022-07-15.
//

import Foundation
import UIKit
import SwiftUI

class ViewControllerB : UIViewController{

    var hostingreference = UIHostingController(rootView: userAccountPage())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        view.addSubview(hostingreference.view)
        setUpConstraint()
    }

    func setUpConstraint(){
//        hostingreference.additionalSafeAreaInsets.top = 144.0
//        hostingreference.heightAnchor.constraint(equalTo: 200).isActive = true
        hostingreference.view.translatesAutoresizingMaskIntoConstraints = false
        hostingreference.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingreference.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hostingreference.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hostingreference.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
}
