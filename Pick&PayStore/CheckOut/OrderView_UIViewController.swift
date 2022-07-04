//
//  OrderView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/2/22.
//

import UIKit

class OrderView_UIViewController: UIViewController {

    @IBOutlet weak var buttonPlaceOrderLabel: UIButton!
    @IBOutlet weak var viewBillingAddress: UIView!
    @IBOutlet weak var viewShippingAddress: UIView!
    @IBOutlet weak var viewOrderSummary: UIView!
    @IBOutlet weak var labelOrderTotal: UILabel!
    @IBOutlet weak var labelGSTHST: UILabel!
    @IBOutlet weak var labelTotalBeforeTax: UILabel!
    @IBOutlet weak var labelShippingFee: UILabel!
    @IBOutlet weak var labelItemSubtotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderSummary_ReloadData()
        configureViewByTenderType()
    }
    
    // MARK: ORDER SUMMARY VIEW CONFIGURATION
    func orderSummary_ReloadData() {
        let cartSummary = ShoppingCartView_UIViewController().shoppingCartView_GetCartSummary()
        let itemSubtotal: Float = cartSummary.cartTotalBeforeTax
        let shippingFee: Float = cartSummary.shippingFee
        let totalBeforeTax: Float = itemSubtotal + shippingFee
        let estimatedGSTHST: Float = totalBeforeTax * 0.13
        let orderTotal: Float = totalBeforeTax + estimatedGSTHST
        
        labelItemSubtotal.text = floatToStringForCurr(amount: itemSubtotal)
        labelShippingFee.text = floatToStringForCurr(amount: shippingFee)
        labelTotalBeforeTax.text = floatToStringForCurr(amount: totalBeforeTax)
        labelGSTHST.text = floatToStringForCurr(amount: estimatedGSTHST)
        labelOrderTotal.text = floatToStringForCurr(amount: orderTotal)
    }
    
    func floatToStringForCurr(amount: Float) -> String {
        return ("$" + String(format: "%.2f", amount))
    }
    
    //MARK: VIEW POPULATION ACCORDING TO TENDER TYPE
    func configureViewByTenderType() {
        
        if let tenderType = tenderTypes
            .first(where: { $0.tenderTypeID == selectedTenderType!}) {
            print("Selected tender type:" + tenderType.tenderTypeDesc)
            buttonPlaceOrderLabel.setTitle("Pay with \(tenderType.tenderTypeDesc)", for: .normal)
        }
        
        switch selectedTenderType! {
        case 1:
            print("Billing address is required.")
        default:
            viewBillingAddress.removeFromSuperview()
            print("Switch is exhaustive.")
        }
    }
}


let addressFormFields: [(fieldName: String, fieldIsRequired: Bool)] = [
    ("Name", true),
    ("Address Line 1", true),
    ("Address Line 2", false), //optional
    ("City", true),
    ("Province/State", true),
    ("Postal/ZIP Code", true),
    ("Country", true)
]

// MARK: CONFIGURE BILLING ADDRESS FORM
extension OrderView_UIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressFormFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shippingAddressFormCell = tableView.dequeueReusableCell(withIdentifier: "billingAddressFormCell", for: indexPath) as! OrderView_UITableViewCellShipping
        
        if addressFormFields[indexPath.row].1 {
            shippingAddressFormCell.labelShippingAddressFieldRequired.text = "*"
            shippingAddressFormCell.labelShippingAddressFieldRequired.textColor = .red
        } else {
            shippingAddressFormCell.labelShippingAddressFieldRequired.text = ""
            shippingAddressFormCell.labelShippingAddressFieldRequired.textColor = view.backgroundColor
        }
        
        shippingAddressFormCell.textFieldShippingAddressField.placeholder = addressFormFields[indexPath.row].0
        
        return shippingAddressFormCell
    }
}
