//
//  EmptyCartViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/16/22.
//

import UIKit

class EmptyCartViewController: UIViewController {

    @IBAction func buttonContinueShopping(_ sender: Any) {
        // present home tab by switching the selected vc
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC")
        self.parent?.tabBarController?.selectedViewController = self.parent?.tabBarController?.viewControllers![0]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
