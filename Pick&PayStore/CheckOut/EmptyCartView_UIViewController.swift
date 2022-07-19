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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //CartService.cartServiceInstance.resetCart()
//        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
//        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 1, quantity: 2)

    }

    
    func presentVC(storyboardName: String, vcStoryboardID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: vcStoryboardID)
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: true)
        present(viewController, animated: true, completion: nil)
//        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![1]
    }
    
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
//            let buttonSignUp = UIButton()
//            buttonSignUp.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2, width: 270, height: 45)
//            buttonSignUp.backgroundColor = .lightGray
//            buttonSignUp.setTitle("Sign up now", for: .normal)
//            buttonSignUp.addTarget(self, action: #selector(buttonSignUp_DidTouchUpInside), for: .touchUpInside)
//            viewButtonsEmptyCart.addSubview(buttonSignUp)
            
            //button - continue shopping
            let buttonContinueShopping = UIButton()
            buttonContinueShopping.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2 + 65, width: 270, height: 45)
            buttonContinueShopping.backgroundColor = buttonColor
            buttonContinueShopping.setTitle("Continue Shopping", for: .normal)
            buttonContinueShopping.addTarget(self, action: #selector(buttonContinueShopping_DidTouchUpInside), for: .touchUpInside)
            
            viewButtonsEmptyCart.addSubview(buttonContinueShopping)
            
            //button - sign in
//            let buttonSignIn = UIButton()
//            buttonSignIn.frame = CGRect(x: (self.viewButtonsEmptyCart.frame.width - 270) / 2, y: (self.viewButtonsEmptyCart.frame.height - 45) / 2 - 65, width: 270, height: 45)
//            buttonSignIn.backgroundColor = buttonColor
//            buttonSignIn.setTitle("Sign in to your account", for: .normal)
//            buttonSignIn.addTarget(self, action: #selector(buttonSignIn_DidTouchUpInside), for: .touchUpInside)
//            
//            viewButtonsEmptyCart.addSubview(buttonSignIn)

        }
    }
    
    // TODO: UPDATE BUTTON EVENTS
    @objc func buttonContinueShopping_DidTouchUpInside(sender: UIButton!) {
        print("buttonContinueShopping_DidTouchUpInside")
        // present home tab by switching the selected vc
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC")
        self.parent?.tabBarController?.selectedViewController = self.parent?.tabBarController?.viewControllers![0]
    }
    
    @objc func buttonSignIn_DidTouchUpInside(sender: UIButton!) {
        print("buttonSignIn_DidTouchUpInside")
    }
    
    @objc func buttonSignUp_DidTouchUpInside(sender: UIButton!) {
        print("buttonSignUp_DidTouchUpInside")
    }
}
