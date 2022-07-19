//
//  UserCartViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/16/22.
//

import UIKit

class UserCartViewController: UIViewController {

    //MODEL PREPARATION
    var cartItemData: [(item: Product, cartQty: Int64)] = [] //data arr for the model
    
    //PREPARE NOTIFICATION TO RECEIVE POSTS FROM CELL BUTTONS
    static let notification = Notification.Name("updateCartQty") //notification static var defining name
    static let vc = UserCartViewController()
    var productID_UpdateCartQty: Int64?
    var updateType_UpdateCartQty: Int?
    var indexPathRow_UpdateCartQty: Int?
    
    //PROPERTIES USED TO LOAD CART SUMMARY
    var isShippingFree: Bool?
    var hasInsufficientStock: Bool = false

    
    //CART REF OUTLETS
    @IBOutlet weak var labelItemSubtotal: UILabel!
    @IBOutlet weak var labelShippingFee: UILabel!
    @IBOutlet weak var buttonProceed: UIButton!
    @IBOutlet weak var tableViewCartItems: UITableView!
    
    
    //MARK: PART 1 - LOAD CART MODEL
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if cartItemData.count != 0 {
            cartItemData.removeAll()
        }
        
        let cart = CartService.cartServiceInstance.getCart()
        
        for i in 0...cart.items!.count - 1 {
            //itemsInCart.append(Int64(cart.items![i]))
            let item: Product = ProductsService.productsServiceInstance.getOneProduct(id: Int64(cart.items![i]))
            let itemQty: Int64 = Int64(CartService.cartServiceInstance.getCart().quantity![i])
            cartItemData.append((item: item, cartQty: itemQty))
        }
        
        tableViewCartItems.reloadData()
        tableViewCartItems.showsVerticalScrollIndicator = false
        
        //ADD SUBSCRIBER INTO NOTIFICATION CENTER
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateCartQty(notification:)), name: UserCartViewController.notification, object: nil)
        
        cartSummaryView_ReloadData()
    }
    
    //MARK: PART 5 - CLEAN UP MODEL AND NOTIFICATION SUBSCRIPTION
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //REMOVE SUBSCRIBER FROM NOTIFICATION CENTER (REQUIRED TO AVOID DUPLICATE ITEM UPDATES)
        NotificationCenter.default.removeObserver(self, name: UserCartViewController.notification, object: nil)
        
        //CLEAN UP MODEL
        if cartItemData.count != 0 {
            cartItemData.removeAll()
        }
    }
}

//MARK: PART 2 - CONFIGURE NOTIFICATION SUBSCRIBER TO UDPATE CART QTY
extension UserCartViewController {
    @objc func handleUpdateCartQty(notification: Notification) {
        switch UserCartViewController.vc.updateType_UpdateCartQty {
        case -1:
            decreaseCartQty()
        case 1:
            increaseCartQty()
        case 0:
            removeProductFromCart()
        default:
            print("handleUpdateCartQty: Switch is exhaustive.")
        }
        tableViewCartItems.reloadData()
    }
    
    func increaseCartQty() {
        //INCREASE CART QTY FOR ITEM IN VIEW & CORE DATA
        let index = UserCartViewController.vc.indexPathRow_UpdateCartQty!
        cartItemData[index].cartQty += 1
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: UserCartViewController.vc.productID_UpdateCartQty!, quantity: 1)
        
        tableViewCartItems.reloadData()
        cartSummaryView_ReloadData()
    }
    func decreaseCartQty() {
        //DECREASE CART QTY FOR ITEM IN VIEW & CORE DATA
        let index = UserCartViewController.vc.indexPathRow_UpdateCartQty!
        let currentCartQty = CartService.cartServiceInstance.getCart().quantity![index]
        if currentCartQty == 1 {
            removeProductFromCart()
        } else {
            cartItemData[index].cartQty -= 1
            CartService.cartServiceInstance.addUpdateItemToCart(itemId: UserCartViewController.vc.productID_UpdateCartQty!, quantity: -1)
            
            tableViewCartItems.reloadData()
            cartSummaryView_ReloadData()
        }
    }
    func removeProductFromCart() {
        //SHOW ALERT FOR ITEM REMOVAL
        let alertBeforeRemoval = UIAlertController(title: "Delete Item?", message: "You're about to delete the item from your cart. Please select Confirm to proceed or Cancel to go back.", preferredStyle: .alert)
        let alertBeforeRemoval_ActionContinue = UIAlertAction(title: "Continue", style: .destructive, handler: {_ in
            
            //REMOVE ITEM FROM VIEW AND CORE DATA
            CartService.cartServiceInstance.removeItemFromCart(itemId: UserCartViewController.vc.productID_UpdateCartQty!)
            self.cartItemData.remove(at: UserCartViewController.vc.indexPathRow_UpdateCartQty!)
            
            if self.cartItemData.count != 0 {
                self.tableViewCartItems.reloadData()
                self.cartSummaryView_ReloadData()
            } else {
                //IF THE REMOVED ITEM IS LAST PRODUCT, PRESENT HOME SCREEN
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "mainVC")
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }

        })
        let alertBeforeRemoval_ActionCancel = UIAlertAction(title: "Cancel", style: .default)
        alertBeforeRemoval.addAction(alertBeforeRemoval_ActionContinue)
        alertBeforeRemoval.addAction(alertBeforeRemoval_ActionCancel)
        present(alertBeforeRemoval, animated: true)
    }
    
    //MARK: PART 3 - CART SUMMARY DATASOURCE
    func cartSummaryView_ReloadData() {
        
        //1. calculate subtotal & count of items & overall stock status
        var subTotal: Float = 0
        var countOfItem: Int = 0
        
        for i in 0...cartItemData.count - 1 {
            let model: (item: Product, cartQty: Int64) = cartItemData[i]
            let viewModel: UserCartViewModel = UserCartViewModel(indexPathRowOfProduct: 0, productID: model.item.id, imageName: model.item.image!, productDesc: model.item.name!, productUnitPrice: model.item.price, productStockQty: model.item.quantity, productCartQty: model.cartQty, freeShipping: true)
            let itemTotal: Float = viewModel.productUnitPrice * Float(viewModel.productCartQty)
            countOfItem += Int(viewModel.productCartQty)
            subTotal += itemTotal
            hasInsufficientStock = false
            if hasInsufficientStock {
                continue
            } else {
                if viewModel.productCartQty > viewModel.productStockQty {
                    hasInsufficientStock = true
                }
            }
            
        }
        //2. shipping fee waiver
        self.isShippingFree = subTotal >= 200
        
        //3. configure cart summary ref outlets
        labelItemSubtotal.text = SharedServices.service.format_priceValFormatter(priceVal: subTotal, currency: "$", decimalPlaces: 2)
        
        labelShippingFee.text = isShippingFree! ? "Your order qualifies for FREE shipping." : "Shipping fee will be $10.00 for this order."
        
        
        if hasInsufficientStock {
            buttonProceed.isUserInteractionEnabled = false
            buttonProceed.tintColor = .lightGray
            buttonProceed.setTitle("There're items with insuffient stock. Change the quantity and try again.", for: .normal)
        } else {
            buttonProceed.isUserInteractionEnabled = true
            buttonProceed.tintColor = UIColor(named: "darkYellow")
            
            if countOfItem == 1 {
                buttonProceed.setTitle("Proceed to checkout (1 item)", for: .normal)
            } else {
                buttonProceed.setTitle("Proceed to checkout (\(countOfItem) items)", for: .normal)
            }
        }
        
        //4. pass subtotal to configure tenderType
        TenderTypeViewController.vc.cartSubtotal = subTotal
    }
}

//MARK: PART 4 - CART TABLE VIEW DATASOURCE
extension UserCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier_CartToPay.userCart.rawValue, for: indexPath) as! UserCartTableViewCell
        let row = indexPath.row
        let model: (item: Product, cartQty: Int64) = cartItemData[row]
        
        let viewModel: UserCartViewModel = UserCartViewModel(indexPathRowOfProduct: row, productID: model.item.id, imageName: model.item.image!, productDesc: model.item.name!, productUnitPrice: model.item.price, productStockQty: model.item.quantity, productCartQty: model.cartQty, freeShipping: self.isShippingFree!)
        cell.configure(viewModel: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard isShippingFree == nil else {
            return isShippingFree! ? "" : "Shipping fee: $10.00"
        }
        return ""
    }
}
