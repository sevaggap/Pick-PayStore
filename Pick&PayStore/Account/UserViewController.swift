//
//  UserViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import UIKit
import SwiftUI
class UserViewController: UIViewController {
    
    //@IBOutlet weak var hostView: UIView!
    //FIXME: UPDATE ROOTVIEW ACCORDING TO LOGIN STATUS
    let hostingController = UIHostingController(rootView: UserView())

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LoginStatus.status.isLoggedIn {
//            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "orderHistoryVC")
//            view.addSubview(vc.view)
            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "orderHistoryVC")
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        UNUserNotificationCenter.current().delegate = self
        
        if !LoginStatus.status.isLoggedIn {
            view.addSubview(hostingController.view)
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
            hostingController.view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
            hostingController.view.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
            
//            hostingController.view.isOpaque = false
//            hostingController.view?.backgroundColor = .clear
        }

        
    }
}
