//
//  OrderHistoryView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/14/22.
//

import UIKit

class OrderHistoryView_UIViewController: UIViewController {
    
    static var vc = OrderHistoryView_UIViewController()
    
    var orderHistory_selectedOrderHID: Int?
    
    var userID = 54322
    var orderHeaderArr: [(
        orderHeaderID: Int,
        orderTotal: Float,
        orderItemSubtotal: Float,
        orderShippingFee: Float,
        orderTax: Float,
        orderTenderType: Int,
        orderDate: String
    )] = []
    
    var orderID: [Int] = []
    
    @IBAction func buttonHomePage(_ sender: Any) {
        buttonHomePage_didTouchUpInside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderID = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byUserID(userID: "\(userID)", isFetchingLatest: false)
        print(orderID)
        
        
        for order in orderID {
            let orderHeader: (
                orderHeaderID: Int,
                orderTotal: Float,
                orderItemSubtotal: Float,
                orderShippingFee: Float,
                orderTax: Float,
                orderTenderType: Int,
                orderDate: String
            )?
            orderHeader = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byOrderHID(orderID: order)
            orderHeaderArr.append(orderHeader!)
            print(orderHeaderArr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func buttonHomePage_didTouchUpInside() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainVC")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}

//MARK: CONFIG TABLE VIEW & CELL
extension OrderHistoryView_UIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderHeaderCell = tableView.dequeueReusableCell(withIdentifier: "orderHeaderCell", for: indexPath) as! OrderHistoryView_UITableViewCell
        orderHeaderCell.selectionStyle = .none
        
        let order = orderHeaderArr[orderHeaderArr.count - indexPath.row - 1]
        orderHeaderCell.labelOrderHID.text = "\(order.orderHeaderID)"
        orderHeaderCell.labelOrderTotal.text = "$\(roundFloatToTwoDecimal(amount: order.orderTotal))"
        orderHeaderCell.labelOrderDate.text = "\(dateFormatDBtoCal(dbDate: order.orderDate))"

        orderHeaderCell.labelOrderTenderType.text = ""
        orderHeaderCell.labelOrderTax.text = ""
        orderHeaderCell.labelOrderShippingFee.text = ""
        orderHeaderCell.labelOrderItemSubtotal.text = ""
        
        let firstItem: Int = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderItem_byOrderHID(orderID: order.orderHeaderID)[0]
        let imageName = ProductsService.productsServiceInstance.getOneProduct(id: Int64(firstItem)).image!
        orderHeaderCell.imageFirstItem.image = UIImage(named: imageName)
        return orderHeaderCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")
        let selectedRow = indexPath.row
        let order = orderID[orderID.count - selectedRow - 1]
        print("Selected order: \(order)")
        OrderHistoryView_UIViewController.vc.orderHistory_selectedOrderHID = order
        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "orderDetailVC")
        present(vc, animated: true, completion: nil)
    }
    
    func roundFloatToTwoDecimal(amount: Float) -> Float {
        return round(amount * 100) / 100.0
    }
    
    
    // this function handles the formatting of the date for notes, using logic to display AM or PM depening on the hour value
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
