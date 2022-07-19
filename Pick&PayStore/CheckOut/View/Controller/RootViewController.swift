//
//  RootViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/16/22.
//

import UIKit

class RootViewController: UIViewController {
    
    var userDidLogIn: Bool = false
    var cartIsEmpty: Bool = true
    
    //MARK: PART 1 - Referencing Outlets for the Container Views
    @IBOutlet weak var container_GuestCart: UIView!
    @IBOutlet weak var container_EmptyCart: UIView!
    @IBOutlet weak var container_UserCart: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //MARK: PART 2 - GET LOGIN & CART STATUS
        userDidLogIn = LoginStatus.status.isLoggedIn
        
        let cart = CartService.cartServiceInstance.getCart()
        cartIsEmpty = cart.items?.count == 0
        print("RootViewController_cartIsEmpty: \(cartIsEmpty)")
        
        //MARK: PART 3 - CONFIGURE CONTAINER VIEWS ACCORDING TO LOGIN & CART STATUS
        //Preload the container views
        view.addSubview(container_GuestCart)
        view.addSubview(container_EmptyCart)
        view.addSubview(container_UserCart)
        
        if userDidLogIn {
            container_GuestCart.removeFromSuperview()
            if cartIsEmpty {
                container_UserCart.removeFromSuperview()
                SharedServices.service.configure_containerViewFullScreen(containerView: container_EmptyCart, parentView: view)
            } else {
                container_EmptyCart.removeFromSuperview()
                SharedServices.service.configure_containerViewFullScreen(containerView: container_UserCart, parentView: view)
            }
        } else {
            container_EmptyCart.removeFromSuperview()
            container_UserCart.removeFromSuperview()
            SharedServices.service.configure_containerViewFullScreen(containerView: container_GuestCart, parentView: view)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
