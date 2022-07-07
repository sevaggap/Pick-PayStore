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
        buttonProceedToCheckOut_DidTouchUpInside()
    }
    @IBOutlet weak var buttonProceedToCheckOut: UIButton!
    @IBOutlet weak var labelFreeShipping: UILabel!
    @IBOutlet weak var labelSubtotalAmount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: GET SHOPPING CART ITEMS
        cartDetailItems.append((productID: 1,
                                productName: "TestProduct 1",
                                stockQty: 2,
                                cartQty: 5,
                                price: 1200,
                                imageName: "Checkout-SampleItem"))
        cartDetailItems.append((productID: 2,
                                productName: "TestProduct 2",
                                stockQty: 5,
                                cartQty: 2,
                                price: 10,
                                imageName: "Checkout-SampleItem"))
        cartDetailItems.append((productID: 3,
                                productName: "TestProduct 3",
                                stockQty: 5,
                                cartQty: 1,
                                price: 6.5,
                                imageName: "Checkout-SampleItem"))
    shoppingCartSummaryView_ReloadData()
    }
}
// MARK: CART SUMMARY VIEW CONFIGURATION
extension ShoppingCartView_UIViewController {
    func shoppingCartView_GetCartSummary() -> (cartTotalBeforeTax: Float,
                                               isFreeShipping: Bool,
                                               shippingFee: Float,
                                               countOfItems: Int64,
                                               hasInsufficientStock: Bool) {
        var cartTotalBeforeTax: Float = 0
        var isFreeShipping = false
        var shippingFee: Float = 0
        var totalCartQty: Int64 = 0
        var totalStockQty: Int64 = 0
        var hasInsufficientStock: Bool = false
        
        for item in cartDetailItems {
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
        
        if cartTotalBeforeTax >= 200 {
            shippingFee = 0
            isFreeShipping = true
        } else {
            shippingFee = 10
        }
        
        return (cartTotalBeforeTax, isFreeShipping, shippingFee, totalCartQty, hasInsufficientStock)
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
        if !shoppingCartView_GetCartSummary().hasInsufficientStock {
            //TODO: PRESENT PAYMENT SELECTION SCREEN
            print("PRESENT PAYMENT SELECTION SCREEN.")
            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
            let paymentMethodVC = storyboard.instantiateViewController(withIdentifier: "paymentMethodVC")
            paymentMethodVC.modalPresentationStyle = .fullScreen
            self.present(paymentMethodVC, animated: true)
        } else {
            print("USER INTERACTION DISABLED.")
        }
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
        tableViewCartDetail.reloadData()
        shoppingCartSummaryView_ReloadData()
    }
    func buttonDecreaseQty_DidTouchUpInside(currentRow: Int) {
        if cartDetailItems[currentRow].cartQty == 1 {
            buttonDeleteItem_DidTouchUpInside(currentRow: currentRow)
        } else {
            cartDetailItems[currentRow].cartQty -= 1
            tableViewCartDetail.reloadData()
            shoppingCartSummaryView_ReloadData()
        }
    }
    func buttonDeleteItem_DidTouchUpInside(currentRow: Int) {

        let alertBeforeRemoval = UIAlertController(title: "Delete Item?", message: "You're about to delete the item from your cart. Please select Confirm to proceed or Cancel to go back.", preferredStyle: .alert)
        let alertBeforeRemoval_ActionContinue = UIAlertAction(title: "Continue", style: .destructive, handler: {_ in
            cartDetailItems.remove(at: currentRow)
            self.tableViewCartDetail.reloadData()
            self.shoppingCartSummaryView_ReloadData()
        })
        let alertBeforeRemoval_ActionCancel = UIAlertAction(title: "Cancel", style: .default)
        alertBeforeRemoval.addAction(alertBeforeRemoval_ActionContinue)
        alertBeforeRemoval.addAction(alertBeforeRemoval_ActionCancel)
        present(alertBeforeRemoval, animated: true)
        
    }
}
