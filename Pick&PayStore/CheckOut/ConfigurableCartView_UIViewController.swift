//
//  ConfigurableCartView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/13/22.
//

import UIKit

class ConfigurableCartView_UIViewController: UIViewController {
    
    var userDidLogedIn: Bool = false
    
    static var configurator = ConfigurableCartView_UIViewController()
    @IBOutlet weak var cartContainerView: UIView!
    @IBOutlet weak var emptyCartContainerView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userDidLogedIn = LoginStatus.status.isLoggedIn

        configContainerViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func cartIsEmpty() -> Bool {
        var cartIsEmpty: Bool = true
        let cart = CartService.cartServiceInstance.getCart()
        if cart.items!.count != 0 {
            cartIsEmpty = false
        }
        
        return cartIsEmpty
    }
    
    func applyConstraints(myView: UIView) {
        //var constraints: [NSLayoutConstraint] = []
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        myView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
    }
    
    func configContainerViews() {

        view.addSubview(cartContainerView)
        view.addSubview(emptyCartContainerView)
        if cartIsEmpty() {
            applyConstraints(myView: emptyCartContainerView)
            cartContainerView.removeFromSuperview()
            
        } else {
            applyConstraints(myView: cartContainerView)
            emptyCartContainerView.removeFromSuperview()
        }
    }
}
