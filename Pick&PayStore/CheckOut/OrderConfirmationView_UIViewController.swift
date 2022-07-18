//
//  OrderConfirmationView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/8/22.
//

import UIKit

class OrderConfirmationView_UIViewController: UIViewController {

    @IBAction func buttonOrderHistory(_ sender: Any) {
        buttonOrderHistory_didTouchUpInside()
    }
    @IBAction func buttonHomePage(_ sender: Any) {
        buttonHomePage_didTouchUpInside()
    }
    @IBOutlet weak var labelOrderTotal: UILabel!
    @IBOutlet weak var labelOrderNumber: UILabel!
    
    var orderHID = 0
    var userID = 54322
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderHID = getOrderHID(user: 54322)
        orderItems = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderItem_byOrderHID(orderID: orderHID)
        updateOrderTotal()
        updateOrderNumber()
    }
    
    func updateOrderTotal() {
        labelOrderTotal.text = "$" + String(round(OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byOrderHID(orderID: orderHID) * 100) / 100.0)
    }
    func updateOrderNumber() {
        labelOrderNumber.text = String(orderHID)
    }
    var orderItems: [(Int, Int)] = []
    func getOrderHID(user: Int) -> Int {
        return (OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byUserID(userID: String(userID), isFetchingLatest: true)[0])
    }
}

extension OrderConfirmationView_UIViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderConfItemCell = tableView.dequeueReusableCell(withIdentifier: "orderConfItemCell", for: indexPath) as! OrderConfirmationView_UITableViewCell
        let productID = orderItems[indexPath.row].0
        let productQty = orderItems[indexPath.row].1
        
        orderConfItemCell.imageItemImage.image = UIImage(named: ProductsHelper.productsHelper.getProduct(id: Int64(productID)).image!)
        orderConfItemCell.labelItemDesc.text = ProductsHelper.productsHelper.getProduct(id: Int64(productID)).name
        orderConfItemCell.labelItemQty.text = String(productQty)
        let itemPrice = ProductsHelper.productsHelper.getProduct(id: Int64(productID)).price
        orderConfItemCell.labelItemSubtotal.text = "$" + String(Float(productQty) * itemPrice)
        
        return orderConfItemCell
    }
    
    func buttonHomePage_didTouchUpInside() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainVC")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func buttonOrderHistory_didTouchUpInside() {
        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "orderHistoryVC")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
}
