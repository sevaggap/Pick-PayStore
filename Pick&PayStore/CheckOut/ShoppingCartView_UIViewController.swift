//
//  ShoppingCartView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 6/30/22.
//

import UIKit



// TODO: !!!-CART ITEMS: [NSNUMBER] => [(PRODUCT, INT64-QUANTITY)]
// productID, productName, stockQuantity, cartQuantity, price, imageName
var cartDetailItems: [(productID: Int64,
                       productName: String,
                       stockQty: Int64,
                       cartQty: Int64,
                       price: Float,
                       imageName: String)] = []

class ShoppingCartView_UIViewController: UIViewController {
    
    
    @IBOutlet weak var tableViewCartDetail: UITableView!
    @IBAction func buttonProceedToCheckOut(_ sender: Any) {
        
        if LoginStatus.status.isLoggedIn {
            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "paymentMethodVC")
            
            navigationController?.pushViewController(vc, animated: false)
        } else {
            SharedServices.service.alertMessage(title: "You're not signed in yet.", message: "Please sign in first to place an order.")
        }
        
    }
    @IBOutlet weak var buttonProceedToCheckOut: UIButton!
    @IBOutlet weak var labelFreeShipping: UILabel!
    @IBOutlet weak var labelSubtotalAmount: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: GET SHOPPING CART ITEMS
        getDataFromCartAndProduct()

        shoppingCartSummaryView_ReloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let cartIsEmpty = true
        if cartIsEmpty {
            prepareChildVC()
        }

    }
}
// MARK: CART SUMMARY VIEW CONFIGURATION
extension ShoppingCartView_UIViewController {
    
    func shoppingCartView_GetCartSummary() -> (
        AMOUNT_ITEMS: Float,
        AMOUNT_SHIPPING: Float,
        AMOUNT_TAX: Float,
        AMOUNT_GRDTTL: Float,
        cartTotalBeforeTax: Float,
        isFreeShipping: Bool,
        shippingFee: Float,
        countOfItems: Int64,
        hasInsufficientStock: Bool) {
            
            var AMOUNT_ITEMS: Float = 0
            var AMOUNT_SHIPPING: Float = 0
            var AMOUNT_TAX: Float = 0
            var AMOUNT_GRDTTL: Float = 0
            var cartTotalBeforeTax: Float = 0
            var isFreeShipping = false
            var shippingFee: Float = 0
            var totalCartQty: Int64 = 0
            var totalStockQty: Int64 = 0
            var hasInsufficientStock: Bool = false
            var countOfItems: Int64 = 0
            
            for item in cartDetailItems {
                countOfItems += item.cartQty
                
                cartTotalBeforeTax += item.price * Float(item.cartQty)
                totalCartQty += item.cartQty
                if hasInsufficientStock {
                    continue
                } else {
                    if item.cartQty > item.stockQty {
                        hasInsufficientStock = true
                    }
                }
            }
            AMOUNT_ITEMS = cartTotalBeforeTax
            
            if cartTotalBeforeTax >= 200 {
                shippingFee = 0
                AMOUNT_SHIPPING = 0
                isFreeShipping = true
            } else {
                shippingFee = 10
                AMOUNT_SHIPPING = 10
            }
            
            AMOUNT_TAX = (AMOUNT_ITEMS + AMOUNT_SHIPPING) * 0.13
            AMOUNT_GRDTTL = AMOUNT_ITEMS + AMOUNT_SHIPPING + AMOUNT_TAX
            
            
            return (
                AMOUNT_ITEMS,
                AMOUNT_SHIPPING,
                AMOUNT_TAX,
                AMOUNT_GRDTTL,
                cartTotalBeforeTax,
                isFreeShipping,
                shippingFee,
                countOfItems,
                hasInsufficientStock)
        }
    
    func shoppingCartSummaryView_ReloadData() {
        labelSubtotalAmount.text = "$" + String(format: "%.2f", shoppingCartView_GetCartSummary().cartTotalBeforeTax)
        labelFreeShipping.text = shoppingCartView_GetCartSummary().isFreeShipping ? "Your order qualifies for FREE shipping (exclues remote locations). Choose this option at checkout." : "Shipping fee will be $10.00 for this order."
        if shoppingCartView_GetCartSummary().countOfItems == 1 {
            buttonProceedToCheckOut.setTitle("Proceed to checkout (1 item)", for: .normal)
        } else {
            buttonProceedToCheckOut.setTitle("Proceed to checkout (\(shoppingCartView_GetCartSummary().countOfItems) items)", for: .normal)
        }
        
        if shoppingCartView_GetCartSummary().hasInsufficientStock {
            buttonProceedToCheckOut.isUserInteractionEnabled = false
            buttonProceedToCheckOut.backgroundColor = .lightGray
            buttonProceedToCheckOut.setTitle("There're items with insuffient stock. Change the quantity and try again.", for: .normal)
        } else {
            buttonProceedToCheckOut.isUserInteractionEnabled = true
            buttonProceedToCheckOut.backgroundColor = buttonColor
        }
    }
    
    func buttonProceedToCheckOut_DidTouchUpInside() {
        print("buttonProceedToCheckOut_DidTouchUpInside")
//        if !shoppingCartView_GetCartSummary().hasInsufficientStock {
//            //TODO: PRESENT PAYMENT SELECTION SCREEN
//            print("PRESENT PAYMENT SELECTION SCREEN.")
//            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
//            let paymentMethodVC = storyboard.instantiateViewController(withIdentifier: "paymentMethodVC")
//            paymentMethodVC.modalPresentationStyle = .fullScreen
//            self.present(paymentMethodVC, animated: true)
//            //self.performSegue(withIdentifier: "cartToTender", sender: self)
//        } else {
//            print("USER INTERACTION DISABLED.")
//        }
    }
}

// MARK: TABLE VIEW CONFIGURATION
extension ShoppingCartView_UIViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartDetailItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartDetailCell = tableView.dequeueReusableCell(withIdentifier: "cartDetailCell", for: indexPath) as! ShoppingCartView_UITableViewCell
        cartDetailCell.delegate = self
        cartDetailCell.configRow(currentRow: indexPath.row)
        cartDetailCell.selectionStyle = .none
        let productAtRow = cartDetailItems[indexPath.row]
        cartDetailCell.imageCartDetailItemImg.image = UIImage(named: productAtRow.imageName)
        cartDetailCell.labelCartDetailDesc.text = productAtRow.productName
        cartDetailCell.labelCartDetailPrice.text = "$" + String(format: "%.2f", productAtRow.price)
        cartDetailCell.labelCartDetailCartQty.text = String(productAtRow.cartQty)
        
        if productAtRow.cartQty == 1 {
            cartDetailCell.buttonDecreaseQtyOutlet.setImage(UIImage(systemName: "trash"), for: .normal)
        } else {
            cartDetailCell.buttonDecreaseQtyOutlet.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        }
        
        if productAtRow.cartQty > productAtRow.stockQty {
            cartDetailCell.labelCartDetailInStock.text = "Insufficient stock"
            cartDetailCell.labelCartDetailInStock.textColor = .red
        } else {
            cartDetailCell.labelCartDetailInStock.text = "In Stock"
            cartDetailCell.labelCartDetailInStock.textColor = .systemTeal
        }
        
        cartDetailCell.labelCartDetailFreeShipping.text = shoppingCartView_GetCartSummary().isFreeShipping ? "Eligible fore FREE Shipping" : ""
        
        return cartDetailCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: PRESENT PRODUCT PAGE
        print("didSelectRow")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        shoppingCartView_GetCartSummary().isFreeShipping ? "" : "Shipping fee: $10.00"
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        ""
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
}

// MARK: TABLE VIEW CELL BUTTON CONFIGURATION
extension ShoppingCartView_UIViewController: ShoppingCartView_UITableViewCellDelegate {
    func buttonDidTouchUpInside(buttonType: Int, currentRow: Int) {
        print("Tapped: " + ShoppingCartTableViewButtonType[buttonType]! + "at Row \(currentRow)")
        
        switch buttonType {
        case 0: buttonIncreaseQty_DidTouchUpInside(currentRow: currentRow)
        case 1: buttonDecreaseQty_DidTouchUpInside(currentRow: currentRow)
        case 2: buttonDeleteItem_DidTouchUpInside(currentRow: currentRow)
        default: print("Switch is exhaustive.")
        }
    }
    
    func buttonIncreaseQty_DidTouchUpInside(currentRow: Int) {
        
        cartDetailItems[currentRow].cartQty += 1
        setDataToCart_UpdateStkQty(productID: cartDetailItems[currentRow].productID, updatedQty: 1)
        print("Cart Qty of \(cartDetailItems[currentRow].productID) is updated.)")
        tableViewCartDetail.reloadData()
        shoppingCartSummaryView_ReloadData()
    }
    func buttonDecreaseQty_DidTouchUpInside(currentRow: Int) {
        if cartDetailItems[currentRow].cartQty == 1 {
            buttonDeleteItem_DidTouchUpInside(currentRow: currentRow)
        } else {
            cartDetailItems[currentRow].cartQty -= 1
            setDataToCart_UpdateStkQty(productID: cartDetailItems[currentRow].productID, updatedQty: -1)
            tableViewCartDetail.reloadData()
            shoppingCartSummaryView_ReloadData()
        }
    }
    func buttonDeleteItem_DidTouchUpInside(currentRow: Int) {
        
        let alertBeforeRemoval = UIAlertController(title: "Delete Item?", message: "You're about to delete the item from your cart. Please select Confirm to proceed or Cancel to go back.", preferredStyle: .alert)
        let alertBeforeRemoval_ActionContinue = UIAlertAction(title: "Continue", style: .destructive, handler: {_ in
            
            self.setDataToCart_DeleteItemFromCart(productID: cartDetailItems[currentRow].productID)
            cartDetailItems.remove(at: currentRow)
            
            if cartDetailItems.count != 0 {
                self.tableViewCartDetail.reloadData()
                self.shoppingCartSummaryView_ReloadData()
            } else {
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
}


// MARK: DATA INTERACTION - CART & PRODUCT
extension ShoppingCartView_UIViewController {

    func getDataFromCartAndProduct() {
        cartDetailItems.removeAll()
        let cart: Cart = CartService.cartServiceInstance.getCart()
        for i in 0...cart.items!.count-1 {
            let productID = cart.items![i] as! Int64
            let product = ProductsService.productsServiceInstance.getOneProduct(id: productID as! Int64)
            let productName = product.name!
            let stockQty = product.quantity as! Int64
            let cartQty = cart.quantity![i] as! Int64
            let price = product.price
            let imageName = product.image!
            
            cartDetailItems.append((productID: productID,
                                    productName: productName,
                                    stockQty: stockQty,
                                    cartQty: cartQty,
                                    price: price,
                                    imageName: imageName))
        }
        tableViewCartDetail.reloadData()
    }
    
    func setDataToCart_UpdateStkQty(productID: Int64, updatedQty: Int64) {
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: productID, quantity: Int(updatedQty))
        print("Item: \(productID)'s cart qty is updated to: \(updatedQty)")
    }
    
    func setDataToCart_DeleteItemFromCart(productID: Int64) {
        CartService.cartServiceInstance.removeItemFromCart(itemId: productID)
        print("Item: \(productID) has been removed from cart.")
    }
}


//MARK: CHILD VIEW CONTROLLER CONFIGURATION
extension ShoppingCartView_UIViewController {
    func prepareChildVC() {
//        // Create a child view controller and add it to the current view controller.
//        let storyboard = UIStoryboard(name: "CheckOut", bundle: .main)
//        if let viewController = storyboard.instantiateViewController(identifier: "cartVC") as? EmptyCartView_UIViewController {
//           // Add the view controller to the container.
//           addChild(viewController)
//           //view.addSubview(viewController.view)
//            present(viewController, animated: true, completion: nil)
//                    
//           // Create and activate the constraints for the child’s view.
//           //onscreenConstraints = configureConstraintsForContainedView(containedView: viewController.view, stage: .onscreen)
//           //NSLayoutConstraint.activate(onscreenConstraints)
//             
//           // Notify the child view controller that the move is complete.
//           viewController.didMove(toParent: self)
//        }
    }
}
