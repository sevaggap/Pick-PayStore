//
//  CongifurableCartView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/13/22.
//

import UIKit

class CongifurableCartView_UIViewController: UIViewController {
    //var cartIsEmpty: Bool = false

    @IBOutlet weak var cartContainerView: UIView!
    @IBOutlet weak var emptyCartContainerView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
//        constraints.append(view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0))
//        constraints.append(view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0))
//        constraints.append(view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
//        constraints.append(view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0))
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        myView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
    }
}
