//
//  OrderDetailView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/15/22.
//

import UIKit

class OrderDetailView_UIViewController: UIViewController {
    
    var itemArrWithQty: [(Int, Int)] = []
    
    @IBOutlet weak var labelTax: UILabel!
    @IBOutlet weak var labelShippingFee: UILabel!
    @IBOutlet weak var labelItemSubtotal: UILabel!
    @IBOutlet weak var labelOrderTotal: UILabel!
    @IBOutlet weak var labelOrderHID: UILabel!
    @IBOutlet weak var labelTenderType: UILabel!
    @IBOutlet weak var labelOrderDate: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let order: (
            orderHeaderID: Int,
            orderTotal: Float,
            orderItemSubtotal: Float,
            orderShippingFee: Float,
            orderTax: Float,
            orderTenderType: Int,
            orderDate: String
        )?
        
        order = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byOrderHID(orderID: OrderHistoryView_UIViewController.vc.orderHistory_selectedOrderHID!)
        
        labelOrderDate.text = dateFormatDBtoCal(dbDate: order!.orderDate)
        
        switch order?.orderTenderType {
        case 0: labelTenderType.text = "Cash on Delivery (CoD)"
        case 1: labelTenderType.text = "Credit/Debit Card"
        case 2: labelTenderType.text = "Apple Pay"
        default: print("Switch is exhaustive.")
        }
        
        labelOrderHID.text = "\(order!.orderHeaderID)"
        
        labelOrderTotal.text = "$" + String(format: "%.2f", roundFloatToTwoDecimal(amount: order!.orderTotal))
        
        labelItemSubtotal.text = "$" + String(format: "%.2f", roundFloatToTwoDecimal(amount: order!.orderItemSubtotal))
        
        labelShippingFee.text = "$" + String(format: "%.2f", roundFloatToTwoDecimal(amount: order!.orderShippingFee))
        
        labelTax.text = "$" + String(format: "%.2f", roundFloatToTwoDecimal(amount: order!.orderTax))
        
        itemArrWithQty = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderItem_byOrderHID(orderID: order!.orderHeaderID)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func roundFloatToTwoDecimal(amount: Float) -> Float {
        return round(amount * 100) / 100.0
    }
    
    
    func dateFormat(date : Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        let hourFormatter = DateFormatter()
        hourFormatter.timeZone = TimeZone(abbreviation: "EST")
        hourFormatter.dateFormat = "HH"
        
        let minuteFormatter = DateFormatter()
        minuteFormatter.timeZone = TimeZone(abbreviation: "EST")
        minuteFormatter.dateFormat = "mm"
        
        var hourString = hourFormatter.string(from: date)
        let hourInt = Int(hourString)
        let minuteString = minuteFormatter.string(from: date)
        
        if hourInt! > 12 {
             hourString = "\(String(hourInt!-12)):\(minuteString) PM"
        } else if hourInt! == 12 {
            hourString = "\(String(hourInt!)):\(minuteString) PM"
        } else if hourInt! == 0 {
            hourString = "\(String(hourInt! + 12)):\(minuteString) AM"
        } else {
            hourString = "\(String(hourInt!)):\(minuteString) AM"
        }
        
        return dateFormatter.string(from: date) + " " + hourString
        
    }
    
    func dateFormatDBtoCal(dbDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = dateFormatter.date(from: dbDate)
        let calString = dateFormat(date: date!)
        return calString
    }
}

// MARK: CONFIGURE TABLE VIEW & ROW
extension OrderDetailView_UIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArrWithQty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderDetailCell = tableView.dequeueReusableCell(withIdentifier: "orderDetailCell", for: indexPath) as! OrderDetailView_UITableViewCell
        
        orderDetailCell.selectionStyle = .none
        
        let itemID = itemArrWithQty[indexPath.row].0
        
        let item: Product = ProductsService.productsServiceInstance.getOneProduct(id: Int64(itemID))
        
        /*
         @IBOutlet weak var labelItemCartQty: UILabel!
         @IBOutlet weak var labelItemPrice: UILabel!
         @IBOutlet weak var labelItemDesc: UILabel!
         @IBOutlet weak var imageItemImg: UIImageView!
         */
        
        orderDetailCell.imageItemImg.image = UIImage(named: item.image!)
        orderDetailCell.labelItemDesc.text = item.name
        orderDetailCell.labelItemPrice.text = "$" + String(format: "%.2f", roundFloatToTwoDecimal(amount: item.price))
        orderDetailCell.labelItemCartQty.text = "x\(itemArrWithQty[indexPath.row].1)"
        
        return orderDetailCell
    }
    
    
}
