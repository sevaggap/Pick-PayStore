//
//  AccountViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import UIKit

class AccountViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        if SignInViewController.vc.isLoggedIn {
            self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![2]
        }
    }

}
