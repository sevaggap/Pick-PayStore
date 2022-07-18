//
//  TabBarController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-08.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var LoginSignOutButton: UIButton!
    
    var loggedIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loginSignOut()
    }
  
    
    @IBAction func loginRedirect(_ sender: UIButton) {
        
        
        let storyborad = UIStoryboard(name: "Account", bundle: nil)
        let loginScreen = storyborad.instantiateViewController(withIdentifier: "loginVC")
//        navigationController?.pushViewController(loginScreen, animated: true)
        loginScreen.modalPresentationStyle = .fullScreen
        self.present(loginScreen, animated: true, completion: nil)
        
    }
    
    func loginSignOut() {
        if loggedIn {
            LoginSignOutButton.setTitle("Sign Out", for: .normal)
            loggedIn = false
        } else {
            LoginSignOutButton.setTitle("Login", for: .normal)
            loggedIn = true
        }
    }
    
}
