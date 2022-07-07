//
//  EmptyCartView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 6/30/22.
//

import UIKit

//24821776
let buttonColor = UIColor(cgColor: CGColor(red: 248 / 255, green: 217 / 255, blue: 76 / 255, alpha: 1.0))

class EmptyCartView_UIViewController: UIViewController {
    
    // TODO: UPDATE LOGIC TO GET VALUE
    var isUserSignedIn: Bool = false
    
    @IBOutlet weak var viewButtonsEmptyCart: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if isUserSignedIn {
            // TODO: ABSTRACT BUTTON CONFIGURATION
            //button - continue shopping
            let buttonContinueShopping = UIButton()
            buttonContinueShopping.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2, width: 270, height: 45)
            buttonContinueShopping.backgroundColor = buttonColor
            buttonContinueShopping.setTitle("Continue Shopping", for: .normal)
            buttonContinueShopping.titleLabel?.textColor = .black
            buttonContinueShopping.addTarget(self, action: #selector(buttonContinueShopping_DidTouchUpInside), for: .touchUpInside)
            
            viewButtonsEmptyCart.addSubview(buttonContinueShopping)
        } else {
            //button - sign up
            let buttonSignUp = UIButton()
            buttonSignUp.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2, width: 270, height: 45)
            buttonSignUp.backgroundColor = .lightGray
            buttonSignUp.setTitle("Sign up now", for: .normal)
            buttonSignUp.addTarget(self, action: #selector(buttonSignUp_DidTouchUpInside), for: .touchUpInside)
            viewButtonsEmptyCart.addSubview(buttonSignUp)
            
            //button - continue shopping
            let buttonContinueShopping = UIButton()
            buttonContinueShopping.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2 + 65, width: 270, height: 45)
            buttonContinueShopping.backgroundColor = buttonColor
            buttonContinueShopping.setTitle("Continue Shopping", for: .normal)
            buttonContinueShopping.addTarget(self, action: #selector(buttonContinueShopping_DidTouchUpInside), for: .touchUpInside)
            
            viewButtonsEmptyCart.addSubview(buttonContinueShopping)
            
            //button - sign in
            let buttonSignIn = UIButton()
            buttonSignIn.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2 - 65, width: 270, height: 45)
            buttonSignIn.backgroundColor = buttonColor
            buttonSignIn.setTitle("Sign in to your account", for: .normal)
            buttonSignIn.addTarget(self, action: #selector(buttonSignIn_DidTouchUpInside), for: .touchUpInside)
            
            viewButtonsEmptyCart.addSubview(buttonSignIn)

        }
    }
    
    // TODO: UPDATE BUTTON EVENTS
    @objc func buttonContinueShopping_DidTouchUpInside(sender: UIButton!) {
        print("buttonContinueShopping_DidTouchUpInside")
    }
    
    @objc func buttonSignIn_DidTouchUpInside(sender: UIButton!) {
        print("buttonSignIn_DidTouchUpInside")
    }
    
    @objc func buttonSignUp_DidTouchUpInside(sender: UIButton!) {
        print("buttonSignUp_DidTouchUpInside")
    }
}
