//
//  CongifurableCartView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/13/22.
//

import UIKit

class CongifurableCartView_UIViewController: UIViewController {
    //var cartIsEmpty: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //CartService.cartServiceInstance.createCart()
        //CartDBHelper.cartDBHelper.resetCarts()
        //CartService.cartServiceInstance.addUpdateItemToCart(itemId: 10, quantity: 2)
        
        if cartIsEmpty() {
            presentVC(storyboardName: "CheckOut", vcStoryboardID: "emptyCartVC")
        } else {
            presentVC(storyboardName: "CheckOut", vcStoryboardID: "cartVC")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func presentVC(storyboardName: String, vcStoryboardID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: vcStoryboardID)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    func cartIsEmpty() -> Bool {
        var cartIsEmpty: Bool = true
        let cart = CartService.cartServiceInstance.getCart()
        if cart.items!.count != 0 {
            cartIsEmpty = false
        }
        
        return cartIsEmpty
    }
}
