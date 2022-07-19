//
//  SignInViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    static var vc = SignInViewController()
    var isLoggedIn: Bool = false
    

    @IBOutlet var textFieldPassword: [UITextField]!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBAction func buttonLogin(_ sender: Any) {
        guard textFieldEmail.text == nil else {
            if textFieldEmail.text == "xavier@gmail.com" {
                print("username is correct")
                guard textFieldPassword[0].text == nil else {
                    if textFieldPassword[0].text == "!QAZ2wsx" {
                        print("password is correct")
                        SignInViewController.vc.isLoggedIn = true
                        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "orderHistoryVC")
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        present(vc, animated: true)
                    }
                    let alert = UIAlertController(title: "Password incorrect.", message: "Please check your password and try again", preferredStyle: .alert)

                    let alertAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                    return
                }
            } else {
                let alert = UIAlertController(title: "User not found", message: "Please sign up first", preferredStyle: .alert)

                let alertAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(alertAction)
                present(alert, animated: true)
            }
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
