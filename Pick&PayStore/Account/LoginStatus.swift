//
//  LoginStatus.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/19/22.
//

import Foundation
import UIKit

class LoginStatus {
    static let status = LoginStatus()
    var isLoggedIn: Bool = false
    var currentUser: User?
}

class LogOut: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LoginStatus.status.isLoggedIn {
            buttonTitleSetter.setTitle("Sign Out", for: .normal)
        } else {
            buttonTitleSetter.setTitle("Sign In", for: .normal)
        }
    }
    
    @IBOutlet weak var buttonTitleSetter: UIButton!
    @IBAction func buttonLogOut(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "lastUserSwitchedOnKeepLogin")
        
        if LoginStatus.status.isLoggedIn {
            buttonTitleSetter.setTitle("Sign In", for: .normal)
            LoginStatus.status.isLoggedIn = false
            LoginStatus.status.currentUser = nil
            
            let alertController = UIAlertController(title: "Sign Out Succeeded", message: "Thanks for using Pick&Pay Store. To place an order or view your order history, please sign in again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true)
            
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "homeVC")
//            navigationController?.pushViewController(vc, animated: true)
            //self.selectedViewController = self.viewControllers![0]
        } else {
            //buttonTitleSetter.setTitle("Sign Out", for: .normal)
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "userVC")
            self.selectedViewController = self.viewControllers![3]
        }
        
    }
}
