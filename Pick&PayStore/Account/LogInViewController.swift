//
//  LogInViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import UIKit
import SwiftUI
class LogInViewController: UIViewController {

    var hostingreference = UIHostingController(rootView: AccountView())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
        
        view.addSubview(hostingreference.view)
        setUpConstraint()
        hostingreference.view.isOpaque = false
        hostingreference.view.backgroundColor = .clear
    }

    func setUpConstraint(){
        hostingreference.view.translatesAutoresizingMaskIntoConstraints = false
        hostingreference.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingreference.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hostingreference.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hostingreference.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
}
