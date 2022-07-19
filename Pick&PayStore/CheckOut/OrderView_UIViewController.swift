//
//  OrderView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/2/22.
//

import UIKit
import PassKit

var grandTotal: Float = 0.00
class OrderView_UIViewController: UIViewController {
    var orderSummarySA: (
        SA_NAME: String,
        SA_ADDRLINE1: String,
        SA_ADDRLINE2: String,
        SA_CITY: String,
        SA_PROVINCE: String,
        SA_ZIPCODE: String,
        SA_COUNTRY: String
    ) = (
        SA_NAME: "",
        SA_ADDRLINE1: "",
        SA_ADDRLINE2: "",
        SA_CITY: "",
        SA_PROVINCE: "",
        SA_ZIPCODE: "",
        SA_COUNTRY: ""
    )
    static var orderView = OrderView_UIViewController()
    var isPaid = false
    @IBOutlet weak var textFieldSA_Country: UITextField!
    @IBOutlet weak var textFieldSA_PostalCode: UITextField!
    @IBOutlet weak var textFieldSA_City: UITextField!
    @IBOutlet weak var textFieldSA_Province: UITextField!
    @IBOutlet weak var textFieldSA_AddressL2: UITextField!
    @IBOutlet weak var textFieldSA_AddressL1: UITextField!
    @IBOutlet weak var textFieldSA_Name: UITextField!
    //@IBOutlet weak var buttonPlaceOrderLabel: UIButton!
    
    @IBAction func buttonPlaceOrder(_ sender: Any) {
        if validateShippingAddress() {
            buttonPlaceOrder_DidTouchUpInside()
        }
    }
    @IBOutlet weak var buttonPlaceOrderLabel: UIButton!
    @IBOutlet weak var viewBillingAddress: UIView!
    @IBOutlet weak var viewShippingAddress: UIView!
    @IBOutlet weak var viewOrderSummary: UIView!
    @IBOutlet weak var labelOrderTotal: UILabel!
    @IBOutlet weak var labelGSTHST: UILabel!
    @IBOutlet weak var labelTotalBeforeTax: UILabel!
    @IBOutlet weak var labelShippingFee: UILabel!
    @IBOutlet weak var labelItemSubtotal: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        grandTotal = orderSummary_PassTotal()
        OrderView_UIViewController.orderView.orderSummarySA = (
            SA_NAME: "",
            SA_ADDRLINE1: "",
            SA_ADDRLINE2: "",
            SA_CITY: "",
            SA_PROVINCE: "",
            SA_ZIPCODE: "",
            SA_COUNTRY: ""
        )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        orderSummary_ReloadData()
        configureViewByTenderType()
        
        //TODO: UPDATE ACCORDING TO APP LIFECYCLE
        OrderDBHelper.dbHelper.prepareDatabase()
        OrderDBHelper.dbHelper.prepareOrderTables()
        
        //TODO: UPDATE WITH TEXT FIELDS
        viewBillingAddress.removeFromSuperview()
        viewShippingAddress.removeFromSuperview()
    }
    
    
    func orderSummary_PassTotal() -> Float {
        let cartSummary = ShoppingCartView_UIViewController().shoppingCartView_GetCartSummary()
        let itemSubtotal: Float = cartSummary.cartTotalBeforeTax
        let shippingFee: Float = cartSummary.shippingFee
        let orderTotal: Float = (itemSubtotal + shippingFee) * 1.13
        return orderTotal
    }
    
    func orderSummary() -> (
        AMOUNT_ITEMS: Float,
        AMOUNT_SHIPPING: Float,
        AMOUNT_TAX: Float,
        AMOUNT_GRDTTL: Float,
        cartTotalBeforeTax: Float,
        isFreeShipping: Bool,
        shippingFee: Float,
        countOfItems: Int64,
        hasInsufficientStock: Bool) {
        return ShoppingCartView_UIViewController().shoppingCartView_GetCartSummary()
    }
    
    // MARK: ORDER SUMMARY VIEW CONFIGURATION
    func orderSummary_ReloadData() {
        let cartSummary = ShoppingCartView_UIViewController().shoppingCartView_GetCartSummary()
        let itemSubtotal: Float = roundFloatToTwoDecimal(amount: cartSummary.cartTotalBeforeTax)
        let shippingFee: Float = roundFloatToTwoDecimal(amount: cartSummary.shippingFee)
        let totalBeforeTax: Float = roundFloatToTwoDecimal(amount: itemSubtotal + shippingFee)
        let estimatedGSTHST: Float = roundFloatToTwoDecimal(amount: totalBeforeTax * 0.13)
        let orderTotal: Float = roundFloatToTwoDecimal(amount: totalBeforeTax + estimatedGSTHST)
        
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
            buttonPlaceOrderLabel.setTitle("Continue", for: .normal)
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


//MARK: TENDER TYPE CONFIGURATION - APPLE PAY
extension OrderView_UIViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: {() in
        })
        presentOrderConfirmationVC()
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        print("Payment authorized.")
        OrderDBHelper.dbHelper.orderDB_CRUD_CreateOrderHeader(AMOUNT_ITEMS: orderSummary().AMOUNT_ITEMS,
                                                              AMOUNT_SHIPPING: orderSummary().AMOUNT_SHIPPING,
                                                              AMOUNT_TAX: orderSummary().AMOUNT_TAX,
                                                              AMOUNT_GRDTTL: orderSummary().AMOUNT_GRDTTL,
                                                              SA_NAME: textFieldSA_Name.text!,
                                                              SA_ADDRLINE1: textFieldSA_AddressL1.text!,
                                                              SA_ADDRLINE2: textFieldSA_AddressL2.text ?? "",
                                                              SA_CITY: textFieldSA_City.text!,
                                                              SA_PROVINCE: textFieldSA_Province.text!,
                                                              SA_ZIPCODE: textFieldSA_PostalCode.text!,
                                                              SA_COUNTRY: textFieldSA_Country.text!,
                                                              ORDERH_TENDERTYPE: selectedTenderType!)
        isPaid = true
        CartService.cartServiceInstance.resetCart()
    }
    
    func configureTenderType_ApplePay() {
        let request: PKPaymentRequest = {
            let request = PKPaymentRequest()
            
            request.merchantIdentifier = "merchant.xavier.testapplepay"
            request.supportedNetworks = [.amex, .masterCard, .discover, .visa]
            request.supportedCountries = ["CA"]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "CA"
            request.currencyCode = "CAD"
            
            
            //request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Pick&Pay Store CA", amount: NSDecimalNumber(value: roundFloatToTwoDecimal(amount: grandTotal)))]
            let amountFloat = roundFloatToTwoDecimal(amount: grandTotal)
            let amountDouble = Double(amountFloat)
            let amountDecimal = Decimal(amountDouble)
            let amountNSDecimalNumber = NSDecimalNumber(decimal: amountDecimal)
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Pick&Pay Store CA", amount: NSDecimalNumber(string: "\(amountFloat)"))]
            
            return request
        }()
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        
        if controller != nil {
            controller!.delegate = self
            present(controller!, animated: true) {
                print("Payment section closed.")
            }
        } else {
            print("Error.")
        }
    }
    
    func buttonPlaceOrder_DidTouchUpInside() {
        print(selectedTenderType!)
        switch selectedTenderType! {
        case 0: //cash on delivery
            print("CoD selected.")
            print("Payment authorized.")
            OrderDBHelper.dbHelper.orderDB_CRUD_CreateOrderHeader(AMOUNT_ITEMS: orderSummary().AMOUNT_ITEMS,
                                                                  AMOUNT_SHIPPING: orderSummary().AMOUNT_SHIPPING,
                                                                  AMOUNT_TAX: orderSummary().AMOUNT_TAX,
                                                                  AMOUNT_GRDTTL: orderSummary().AMOUNT_GRDTTL,
                                                                  SA_NAME: textFieldSA_Name.text!,
                                                                  SA_ADDRLINE1: textFieldSA_AddressL1.text!,
                                                                  SA_ADDRLINE2: textFieldSA_AddressL2.text ?? "",
                                                                  SA_CITY: textFieldSA_City.text!,
                                                                  SA_PROVINCE: textFieldSA_Province.text!,
                                                                  SA_ZIPCODE: textFieldSA_PostalCode.text!,
                                                                  SA_COUNTRY: textFieldSA_Country.text!,
                                                                  ORDERH_TENDERTYPE: selectedTenderType!)
            isPaid = true
            CartService.cartServiceInstance.resetCart()
            presentOrderConfirmationVC()
        case 1: //credit/debit card
            OrderView_UIViewController.orderView.orderSummarySA = (
                SA_NAME: textFieldSA_Name.text!,
                SA_ADDRLINE1: textFieldSA_AddressL1.text!,
                SA_ADDRLINE2: textFieldSA_AddressL2.text ?? "",
                SA_CITY: textFieldSA_City.text!,
                SA_PROVINCE: textFieldSA_Province.text!,
                SA_ZIPCODE: textFieldSA_PostalCode.text!,
                SA_COUNTRY: textFieldSA_Country.text!
            )
            print("Credit/Debit Card selected.")
            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
            let creditCardVC = storyboard.instantiateViewController(withIdentifier: "ccVC")
//            creditCardVC.modalPresentationStyle = .fullScreen
//            self.present(creditCardVC, animated: true)
            //navigationController?.pushViewController(creditCardVC, animated: true)
            performSegue(withIdentifier: "SAToBA", sender: self)
            
        case 2: //apple pay
            configureTenderType_ApplePay()
            print("Apple pay selected.")
        default:
            print("Unknown tender type.")
        }
        

    }
    
    func roundFloatToTwoDecimal(amount: Float) -> Float {
        print(round(amount * 100) / 100.0)
        return round(amount * 100) / 100.0
    }
}

import SQLite3
class OrderDBHelper {
    static var dbHelper = OrderDBHelper()
    var ordersOfUser: [Int] = []
    var itemsOfOrder: [Int] = []
    var itemsOfOrderWithQty: [(Int, Int)] = []
    var dbpointer: OpaquePointer?
    var sqlStatement = ""
    
    func productBoughtByUser(userID: Int64, productID: Int64) -> Bool {
        var productBoughtByUser = false
        
        let orders = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byUserID(userID: "\(userID)", isFetchingLatest: false)
        
        var products: [Int] = []
        
        for order in orders {
            var productsInOrder: [Int] = []
            productsInOrder = orderDB_CRUD_ReadOrderItem_byOrderHID(orderID: order)
            
            for product in productsInOrder {
                products.append(product)
            }
        }
        
        if products.contains(Int(productID)) {
            productBoughtByUser = true
        }
        
        return productBoughtByUser
    }
    
    /// Obtain SQLite3 error message and print it in the console
    func printSQLiteErrorMsg() {
        let error = String(cString: sqlite3_errmsg(dbpointer)!)
        print("SQLite3 Error: \(error)")
    }
    
    /// Create sqlite database if file does not exist
    func prepareDatabase() {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("PNP_Database.sqlite")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!)
        
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            print("SQLite3 Database is ready")
        }
    }
    
    /// Create the tables for order information in db if do not exist
    func prepareOrderTables() {
        sqlStatement = """
            CREATE TABLE IF NOT EXISTS T_ORDER_H (
                ORDERH_ID            INTEGER NOT NULL  UNIQUE    ,
                AMOUNT_ITEMS         FLOAT(0,2) NOT NULL    ,
                AMOUNT_SHIPPING      FLOAT(0,2) NOT NULL    ,
                AMOUNT_TAX           FLOAT(0,2) NOT NULL    ,
                AMOUNT_GRDTTL        FLOAT(0,2) NOT NULL    ,
                SA_NAME              TEXT NOT NULL    ,
                SA_ADDRLINE1         TEXT NOT NULL    ,
                SA_ADDRLINE2         TEXT     ,
                SA_CITY              TEXT NOT NULL    ,
                SA_PROVINCE          TEXT NOT NULL    ,
                SA_ZIPCODE           TEXT NOT NULL    ,
                SA_COUNTRY           TEXT NOT NULL    ,
                ORDERH_TENDERTYPE    INTEGER NOT NULL    ,
                ORDERH_CREATEDAT     TEXT NOT NULL    ,
                ORDERH_USERID        TEXT NOT NULL    ,
                PRIMARY KEY("ORDERH_ID" AUTOINCREMENT)
             );
        """
        if sqlite3_exec(dbpointer, sqlStatement, nil, nil, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            print("Table T_ORDER_H is ready.")
        }
        sqlStatement = """
            CREATE TABLE IF NOT EXISTS T_ORDER_I (
                ORDERI_ID            INTEGER NOT NULL  UNIQUE    ,
                ORDERH_ID            INTEGER NOT NULL    ,
                ORDERI_CREATEDAT     TEXT NOT NULL    ,
                ITEM_PRODUCTID       TEXT     ,
                ITEM_CARTQTY         INTEGER NOT NULL    ,
                FOREIGN KEY ( ORDERH_ID ) REFERENCES T_ORDER_H( ORDERH_ID )    ,
                PRIMARY KEY("ORDERI_ID" AUTOINCREMENT)
             );
        """
        if sqlite3_exec(dbpointer, sqlStatement, nil, nil, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            print("Table T_ORDER_I is ready.")
        }
    }
    
    ///CRUD - Create/Insert
    func orderDB_CRUD_CreateOrderHeader(
        AMOUNT_ITEMS: Float,
        AMOUNT_SHIPPING: Float,
        AMOUNT_TAX: Float,
        AMOUNT_GRDTTL: Float,
        SA_NAME: String,
        SA_ADDRLINE1: String,
        SA_ADDRLINE2: String,
        SA_CITY: String,
        SA_PROVINCE: String,
        SA_ZIPCODE: String,
        SA_COUNTRY: String,
        ORDERH_TENDERTYPE: Int
    ) {
        prepareDatabase()
        prepareOrderTables()
        var textToInser = ""
        var statement: OpaquePointer?
        sqlStatement = """
            INSERT INTO T_ORDER_H (
                AMOUNT_ITEMS,
                AMOUNT_SHIPPING,
                AMOUNT_TAX,
                AMOUNT_GRDTTL,
                SA_NAME,
                SA_ADDRLINE1,
                SA_ADDRLINE2,
                SA_CITY,
                SA_PROVINCE,
                SA_ZIPCODE,
                SA_COUNTRY,
                ORDERH_TENDERTYPE,
                ORDERH_CREATEDAT,
                ORDERH_USERID) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );
        """
        if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            if sqlite3_bind_double(statement, 1, Double(AMOUNT_ITEMS)) != SQLITE_OK {
                printSQLiteErrorMsg()
            } else {
                if sqlite3_bind_double(statement, 2, Double(AMOUNT_SHIPPING)) != SQLITE_OK {
                    printSQLiteErrorMsg()
                } else {
                    if sqlite3_bind_double(statement, 3, Double(AMOUNT_TAX)) != SQLITE_OK {
                        printSQLiteErrorMsg()
                    } else {
                        if sqlite3_bind_double(statement, 4, Double(AMOUNT_GRDTTL)) != SQLITE_OK {
                            printSQLiteErrorMsg()
                        } else {
                            if sqlite3_bind_text(statement, 5, (SA_NAME as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                printSQLiteErrorMsg()
                            } else {
                                if sqlite3_bind_text(statement, 6, (SA_ADDRLINE1 as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                    printSQLiteErrorMsg()
                                } else {
                                    if sqlite3_bind_text(statement, 7, (SA_ADDRLINE2 as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                        printSQLiteErrorMsg()
                                    } else {
                                        if sqlite3_bind_text(statement, 8, (SA_CITY as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                            printSQLiteErrorMsg()
                                        } else {
                                            if sqlite3_bind_text(statement, 9, (SA_PROVINCE as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                printSQLiteErrorMsg()
                                            } else {
                                                if sqlite3_bind_text(statement, 10, (SA_ZIPCODE as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                    printSQLiteErrorMsg()
                                                } else {
                                                    if sqlite3_bind_text(statement, 11, (SA_COUNTRY as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                        printSQLiteErrorMsg()
                                                    } else {
                                                        if sqlite3_bind_int(statement, 12, Int32(ORDERH_TENDERTYPE)) != SQLITE_OK {
                                                            printSQLiteErrorMsg()
                                                        } else {
                                                            if sqlite3_bind_text(statement, 13, (currentDate_FormattedForSQLDB() as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                                printSQLiteErrorMsg()
                                                            } else {
                                                                
                                                                if sqlite3_bind_text(statement, 14, ("\(LoginStatus.status.currentUser!.userID)" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                                    printSQLiteErrorMsg()
                                                                } else {
                                                                    if sqlite3_step(statement) == SQLITE_DONE {
                                                                        print("Order Header Saved. Please create corresponding item records.")
                                                                        
                                                                        //reset statement once done
                                                                        sqlite3_reset(statement)
                                                                        sqlite3_finalize(statement)
                                                                        sqlite3_close(dbpointer)
                                                                        
                                                                        
                                                                        let countOfOrder = OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byUserID(userID: "\(LoginStatus.status.currentUser!.userID)", isFetchingLatest: true).count
                                                                        if countOfOrder == 0 {
                                                                            
                                                                        } else {
                                                                            let orderHID = (OrderDBHelper.dbHelper.orderDB_CRUD_ReadOrderHeader_byUserID(userID: "\(LoginStatus.status.currentUser!.userID)", isFetchingLatest: true)[0])

                                                                            
                                                                            for item in cartDetailItems {
                                                                                orderDB_CRUD_CreateOrderItem(ORDERH_ID: orderHID, ITEM_PRODUCTID: Int(item.productID), ITEM_CARTQTY: Int(item.cartQty))
                                                                                
                                                                                ProductsService.productsServiceInstance.updateProductStock(id: Int64(item.productID), amount: Int64(item.cartQty))
                                                                                
                                                                                print("Product \(item.productID)'s stock qty is reduced by: \(item.cartQty)")
                                                                            }
                                                                        }
                                                                        
                                                                    } else {
                                                                        printSQLiteErrorMsg()
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func orderDB_CRUD_ReadOrderHeader_byUserID(userID: String, isFetchingLatest: Bool) -> [Int] {
        ordersOfUser.removeAll()
        prepareDatabase()
        prepareOrderTables()
        if isFetchingLatest {
            sqlStatement = """
                SELECT * FROM T_ORDER_H WHERE ORDERH_ID = (SELECT MAX(ORDERH_ID) FROM T_ORDER_H WHERE ORDERH_USERID = \(userID))
            """
            var statement: OpaquePointer?
            
            
            if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_ROW {
                    let orderID = Int(sqlite3_column_int(statement, 0))
                    let amount_items = Float(sqlite3_column_double(statement, 1))
                    let amount_shipping = Float(sqlite3_column_double(statement, 2))
                    let amount_tax = Float(sqlite3_column_double(statement, 3))
                    let amount_grdttl = Float(sqlite3_column_double(statement, 4))
                    let sa_name = String(cString: sqlite3_column_text(statement, 5))
                    let sa_addressLine1 = String(cString: sqlite3_column_text(statement, 6))
                    let sa_addressLine2 = String(cString: sqlite3_column_text(statement, 7))
                    let sa_city = String(cString: sqlite3_column_text(statement, 8))
                    let sa_province = String(cString: sqlite3_column_text(statement, 9))
                    let sa_zipcode = String(cString: sqlite3_column_text(statement, 10))
                    let sa_country = String(cString: sqlite3_column_text(statement, 11))
                    let order_tenderType = Int(sqlite3_column_int(statement, 12))
                    let order_createdAt = String(cString: sqlite3_column_text(statement, 13))
                    let order_userID = String(cString: sqlite3_column_text(statement, 14))
                    
                    print(orderID)
                    print(amount_grdttl)
                    print(order_userID)
                    ordersOfUser.append(orderID)
                    //ordersOfUser = [orderID]
                    
                    //reset statement once done
                    sqlite3_reset(statement)
                    sqlite3_finalize(statement)
                    sqlite3_close(dbpointer)
                    
                } else {
                    print("No result")
                }
            }
        } else {
            sqlStatement = """
                SELECT * FROM T_ORDER_H WHERE ORDERH_USERID = '\(userID)'
            """
            var statement: OpaquePointer?
            
            if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) != SQLITE_OK {
                printSQLiteErrorMsg()
            } else {
                while sqlite3_step(statement) == SQLITE_ROW {
                    let orderID = Int(sqlite3_column_int(statement, 0))
                    ordersOfUser.append(orderID)
                }
            }
        }
        print(ordersOfUser)
        return ordersOfUser
    }
    func orderDB_CRUD_ReadOrderHeader_byOrderHID(orderID: Int) -> (
        orderHeaderID: Int,
        orderTotal: Float,
        orderItemSubtotal: Float,
        orderShippingFee: Float,
        orderTax: Float,
        orderTenderType: Int,
        orderDate: String
    )? {
        prepareDatabase()
        prepareOrderTables()
        sqlStatement = """
            SELECT * FROM T_ORDER_H WHERE (ORDERH_ID = '\(orderID)')
        """
        
        var statement: OpaquePointer?
        
        var orderHeader: (
            orderHeaderID: Int,
            orderTotal: Float,
            orderItemSubtotal: Float,
            orderShippingFee: Float,
            orderTax: Float,
            orderTenderType: Int,
            orderDate: String
        )?
        
        if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let orderID = Int(sqlite3_column_int(statement, 0))
                let amount_items = Float(sqlite3_column_double(statement, 1))
                let amount_shipping = Float(sqlite3_column_double(statement, 2))
                let amount_tax = Float(sqlite3_column_double(statement, 3))
                let amount_grdttl = Float(sqlite3_column_double(statement, 4))
                let sa_name = String(cString: sqlite3_column_text(statement, 5))
                let sa_addressLine1 = String(cString: sqlite3_column_text(statement, 6))
                let sa_addressLine2 = String(cString: sqlite3_column_text(statement, 7))
                let sa_city = String(cString: sqlite3_column_text(statement, 8))
                let sa_province = String(cString: sqlite3_column_text(statement, 9))
                let sa_zipcode = String(cString: sqlite3_column_text(statement, 10))
                let sa_country = String(cString: sqlite3_column_text(statement, 11))
                let order_tenderType = Int(sqlite3_column_int(statement, 12))
                let order_createdAt = String(cString: sqlite3_column_text(statement, 13))
                let order_userID = String(cString: sqlite3_column_text(statement, 14))
                
                orderHeader = (
                    orderHeaderID: orderID,
                    orderTotal: amount_grdttl,
                    orderItemSubtotal: amount_items,
                    orderShippingFee: amount_shipping,
                    orderTax: amount_tax,
                    orderTenderType: order_tenderType,
                    orderDate: order_createdAt
                )
                
            }
            
            //reset statement once done
            sqlite3_reset(statement)
            sqlite3_finalize(statement)
            sqlite3_close(dbpointer)
        }
        return orderHeader
    }
    func orderDB_CRUD_ReadOrderHeader_byOrderHID(orderID: Int) -> Float {
        prepareDatabase()
        prepareOrderTables()
        sqlStatement = """
            SELECT * FROM T_ORDER_H WHERE (ORDERH_ID = '\(orderID)')
        """
        
        var statement: OpaquePointer?
        
        var amount_grandTotal: Float = 0
        
        if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let orderID = Int(sqlite3_column_int(statement, 0))
                let amount_items = Float(sqlite3_column_double(statement, 1))
                let amount_shipping = Float(sqlite3_column_double(statement, 2))
                let amount_tax = Float(sqlite3_column_double(statement, 3))
                let amount_grdttl = Float(sqlite3_column_double(statement, 4))
                let sa_name = String(cString: sqlite3_column_text(statement, 5))
                let sa_addressLine1 = String(cString: sqlite3_column_text(statement, 6))
                let sa_addressLine2 = String(cString: sqlite3_column_text(statement, 7))
                let sa_city = String(cString: sqlite3_column_text(statement, 8))
                let sa_province = String(cString: sqlite3_column_text(statement, 9))
                let sa_zipcode = String(cString: sqlite3_column_text(statement, 10))
                let sa_country = String(cString: sqlite3_column_text(statement, 11))
                let order_tenderType = Int(sqlite3_column_int(statement, 12))
                let order_createdAt = String(cString: sqlite3_column_text(statement, 13))
                let order_userID = String(cString: sqlite3_column_text(statement, 14))
                
                print(orderID)
                print(amount_grdttl)
                print(order_userID)
                amount_grandTotal = amount_grdttl
                
            }
            
            //reset statement once done
            sqlite3_reset(statement)
            sqlite3_finalize(statement)
            sqlite3_close(dbpointer)
        }
        return amount_grandTotal
    }
    
    
    func orderDB_CRUD_CreateOrderItem(ORDERH_ID: Int, ITEM_PRODUCTID: Int, ITEM_CARTQTY: Int) {
        prepareDatabase()
        prepareOrderTables()
        var statement: OpaquePointer?
        sqlStatement = """
            INSERT INTO T_ORDER_I (
                ORDERH_ID,
                ORDERI_CREATEDAT,
                ITEM_PRODUCTID,
                ITEM_CARTQTY) VALUES ( ?, ?, ?, ?);
        """
        
        if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            if sqlite3_bind_int(statement, 1, Int32(ORDERH_ID)) != SQLITE_OK {
                printSQLiteErrorMsg()
            } else {
                if sqlite3_bind_text(statement, 2, (currentDate_FormattedForSQLDB() as! NSString).utf8String, -1, nil) != SQLITE_OK {
                    printSQLiteErrorMsg()
                } else {
                    if sqlite3_bind_text(statement, 3, ("\(ITEM_PRODUCTID)" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                        printSQLiteErrorMsg()
                    } else {
                        if sqlite3_bind_int(statement, 4, Int32(ITEM_CARTQTY)) != SQLITE_OK {
                            printSQLiteErrorMsg()
                        } else {
                            if sqlite3_step(statement) != SQLITE_DONE {
                                printSQLiteErrorMsg()
                            } else {
                                print("Order Item record created.")
                                //reset statement once done
                                sqlite3_reset(statement)
                                sqlite3_finalize(statement)
                                sqlite3_close(dbpointer)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func orderDB_CRUD_ReadOrderItem_byOrderHID(orderID: Int) -> [Int] {
        
        prepareDatabase()
        prepareOrderTables()
        
        itemsOfOrder.removeAll()
        
        sqlStatement = """
            SELECT * FROM T_ORDER_I WHERE ORDERH_ID = \(orderID)
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            while sqlite3_step(statement) == SQLITE_ROW {
                let orderItem_ID = Int(sqlite3_column_int(statement, 0))
                let orderHeader_ID = Int(sqlite3_column_int(statement, 1))
                let order_createdAt = String(cString: sqlite3_column_text(statement, 2))
                let item_ProductID = String(cString: sqlite3_column_text(statement, 3))
                let item_CartQty = Int(sqlite3_column_int(statement, 4))
                itemsOfOrder.append(Int(item_ProductID)!)
            }
            
            //reset statement once done
            sqlite3_reset(statement)
            sqlite3_finalize(statement)
            sqlite3_close(dbpointer)
            
        }
        print(itemsOfOrder)
        return itemsOfOrder
    }
    
    func orderDB_CRUD_ReadOrderItem_byOrderHID(orderID: Int) -> [(Int, Int)] {
        itemsOfOrderWithQty.removeAll()
        prepareDatabase()
        prepareOrderTables()
        sqlStatement = """
            SELECT * FROM T_ORDER_I WHERE ORDERH_ID = \(orderID)
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare(dbpointer, sqlStatement, -1, &statement, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            while sqlite3_step(statement) == SQLITE_ROW {
                let orderItem_ID = Int(sqlite3_column_int(statement, 0))
                let orderHeader_ID = Int(sqlite3_column_int(statement, 1))
                let order_createdAt = String(cString: sqlite3_column_text(statement, 2))
                let item_ProductID = String(cString: sqlite3_column_text(statement, 3))
                let item_CartQty = Int(sqlite3_column_int(statement, 4))
                itemsOfOrderWithQty.append((Int(item_ProductID)!, item_CartQty))
            }
            
            //reset statement once done
            sqlite3_reset(statement)
            sqlite3_finalize(statement)
            sqlite3_close(dbpointer)
        }
        print(itemsOfOrderWithQty)
        return itemsOfOrderWithQty
    }
}

extension OrderDBHelper {
    func currentDate_FormattedForSQLDB() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: Date())
    }
}

extension OrderView_UIViewController {
    func presentOrderConfirmationVC() {
        if isPaid {
            
            print("PRESENTING ORDER CONFIRMATION SCREEN.")
            let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
            let orderConfirmationVC = storyboard.instantiateViewController(withIdentifier: "orderConfirmationVC")
            orderConfirmationVC.modalPresentationStyle = .fullScreen
            self.present(orderConfirmationVC, animated: true)
            //navigationController?.pushViewController(orderConfirmationVC, animated: true)
            
        }
    }
}

extension OrderView_UIViewController {
    func validateShippingAddress() -> Bool {
        var SAIsValid = true
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_Name, isRequired: true)
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_AddressL1, isRequired: true)
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_AddressL2, isRequired: false)
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_Province, isRequired: true)
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_City, isRequired: true)
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_PostalCode, isRequired: true)
        SAIsValid = SAIsValid && textFieldsValidation(textField: textFieldSA_Country, isRequired: true)
        
        print("SAIsValid: \(SAIsValid)")
        return SAIsValid
    }
    func textFieldsValidation(textField: UITextField, isRequired: Bool) -> Bool {
        let fieldName = textField.placeholder!
        var textFieldIsValid: Bool = isRequired ? false : true
        var alertMsg = ""
        print(textField.text)
        //1. if textField.text is nil
        if textField.text! == nil {
            alertMsg = "\(fieldName) is required."
        } else {
            //2. if textField.text is ""
            if textField.text! == "" {
                alertMsg = "\(fieldName) is required."
            } else {
                //3. if textField.text = "     "
                var countOfSpace = 0
                for char in textField.text! {
                    if char == " " {
                        countOfSpace += 1
                    }
                }
                if countOfSpace == textField.text?.count {
                    alertMsg = "\(fieldName) can't be blank."
                } else {
                    textFieldIsValid = true
                    print("textFieldIsValid: \(textFieldIsValid)")
                }
            }
        }
        
        if !textFieldIsValid {
            let alert = UIAlertController(title: "Please check your shipping info.", message: alertMsg, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
        return textFieldIsValid
    }
}
