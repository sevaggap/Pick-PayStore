//
//  PaymentMethodView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/1/22.
//

import UIKit

var selectedTenderType: Int?

var tenderTypes: [(tenderTypeID: Int, imageName: String, tenderTypeDesc: String)] = []

class PaymentMethodView_UIViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        paymentMethodView_ReloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: TABLE VIEW CONFIGURATION
extension PaymentMethodView_UIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tenderTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tenderTypeCell = tableView.dequeueReusableCell(withIdentifier: "tenderTypeCell", for: indexPath) as! PaymentMethodView_UITableViewCell
        tenderTypeCell.selectionStyle = .none
        tenderTypeCell.labelTenderTypeDesc.text = tenderTypes[indexPath.row].tenderTypeDesc
        
        switch tenderTypes[indexPath.row].tenderTypeID {
        case 1:
            tenderTypeCell.imageTenderTypeImg.image = UIImage(systemName: tenderTypes[indexPath.row].imageName)
            tenderTypeCell.imageTenderTypeImg.tintColor = .orange
        default: tenderTypeCell.imageTenderTypeImg.image = UIImage(named: tenderTypes[indexPath.row].imageName)
        }
        
        return tenderTypeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTenderType = tenderTypes[indexPath.row].tenderTypeID
        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
        let paymentVC = storyboard.instantiateViewController(withIdentifier: "orderVC")
//        paymentVC.modalPresentationStyle = .fullScreen
//        self.present(paymentVC, animated: true)
        navigationController?.pushViewController(paymentVC, animated: true)
    }
    
}

//TODO: CONFIG TENDER TYPE ARR ACCORDING TO AMOUNT
extension PaymentMethodView_UIViewController {
    func paymentMethodView_ReloadData() {
        print(cartDetailItems)
        let vc = ShoppingCartView_UIViewController()
        //TODO: CONFIRM IF INCLUDE SHIPPING FEE?
        let totalAmountBeforeTax = vc.shoppingCartView_GetCartSummary().cartTotalBeforeTax
        if totalAmountBeforeTax < 200 {
            tenderTypes = [
                (tenderTypeID: 0, imageName: "TenderType-CoD", tenderTypeDesc: "Cash on Delivery"),
                (tenderTypeID: 1, imageName: "creditcard.fill", tenderTypeDesc: "Debit/Credit Card"),
                (tenderTypeID: 2, imageName: "TenderType-ApplePay", tenderTypeDesc: "Apple Pay")
            ]
        } else {
            tenderTypes = [
                (tenderTypeID: 1, imageName: "creditcard.fill", tenderTypeDesc: "Debit/Credit Card"),
                (tenderTypeID: 2, imageName: "TenderType-ApplePay", tenderTypeDesc: "Apple Pay")
            ]
        }
    }
}
