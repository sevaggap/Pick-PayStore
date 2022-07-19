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
    
    @IBAction func buttonLogOut(_ sender: Any) {
        
        if LoginStatus.status.isLoggedIn {
            LoginStatus.status.isLoggedIn = false
            LoginStatus.status.currentUser = nil
            
            SharedServices.service.alertMessage(title: "Sign Out Succeeded", message: "Thanks for using Pick&Pay Store. To view your cart and order history, please sign in again.")
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homeVC")
            self.selectedViewController = self.viewControllers![0]
        }
        
    }
}
