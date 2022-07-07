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

    @IBAction func buttonPlaceOrder(_ sender: Any) {
        buttonPlaceOrder_DidTouchUpInside()
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        orderSummary_ReloadData()
        configureViewByTenderType()
        
        //TODO: UPDATE ACCORDING TO APP LIFECYCLE
        OrderDBHelper.dbHelper.prepareDatabase()
        OrderDBHelper.dbHelper.prepareOrderTables()
        
        //TODO: REMOVE TEST CODE BELOW
        OrderDBHelper.dbHelper.orderDB_CRUD_CreateOrderHeader()
    }
    
    
    func orderSummary_PassTotal() -> Float {
        let cartSummary = ShoppingCartView_UIViewController().shoppingCartView_GetCartSummary()
        let itemSubtotal: Float = cartSummary.cartTotalBeforeTax
        let shippingFee: Float = cartSummary.shippingFee
        let orderTotal: Float = (itemSubtotal + shippingFee) * 1.13
        return orderTotal
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


//MARK: APPLE PAY CONFIGURATION
extension OrderView_UIViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: {() in
        })
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        self.view.backgroundColor = .green
    }

    func buttonPlaceOrder_DidTouchUpInside() {
        let request: PKPaymentRequest = {
            let request = PKPaymentRequest()
            
            request.merchantIdentifier = "merchant.xavier.testapplepay"
            request.supportedNetworks = [.amex, .masterCard, .discover, .visa]
            request.supportedCountries = ["US", "CA"]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "CA"
            request.currencyCode = "CAD"
            
            
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Pick&Pay Store CA", amount: NSDecimalNumber(value: roundFloatToTwoDecimal(amount: grandTotal)))]
            
            return request
        }()
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        
        if controller != nil {
            controller!.delegate = self
            present(controller!, animated: true) {
                print("Completed")
            }
        } else {
            print("Error.")
        }
    }
    
    func roundFloatToTwoDecimal(amount: Float) -> Float {
        return round(amount * 100) / 100.0
    }
}

import SQLite3
class OrderDBHelper {
    static var dbHelper = OrderDBHelper()
    var dbpointer: OpaquePointer?
    var sqlStatement = ""
    
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
    func orderDB_CRUD_CreateOrderHeader() {
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
            if sqlite3_bind_double(statement, 1, 100.10) != SQLITE_OK {
                printSQLiteErrorMsg()
            } else {
                if sqlite3_bind_double(statement, 2, 0.0) != SQLITE_OK {
                    printSQLiteErrorMsg()
                } else {
                    if sqlite3_bind_double(statement, 3, 13.01) != SQLITE_OK {
                        printSQLiteErrorMsg()
                    } else {
                        if sqlite3_bind_double(statement, 4, 113.01) != SQLITE_OK {
                            printSQLiteErrorMsg()
                        } else {
                            if sqlite3_bind_text(statement, 5, ("Jacky" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                printSQLiteErrorMsg()
                            } else {
                                if sqlite3_bind_text(statement, 6, ("4900 Yonge St" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                    printSQLiteErrorMsg()
                                } else {
                                    if sqlite3_bind_text(statement, 7, ("" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                        printSQLiteErrorMsg()
                                    } else {
                                        if sqlite3_bind_text(statement, 8, ("Toronto" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                            printSQLiteErrorMsg()
                                        } else {
                                            if sqlite3_bind_text(statement, 9, ("ON" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                printSQLiteErrorMsg()
                                            } else {
                                                if sqlite3_bind_text(statement, 10, ("M2M 2R9" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                    printSQLiteErrorMsg()
                                                } else {
                                                    if sqlite3_bind_text(statement, 11, ("Canada" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                        printSQLiteErrorMsg()
                                                    } else {
                                                        if sqlite3_bind_int(statement, 12, 2) != SQLITE_OK {
                                                            printSQLiteErrorMsg()
                                                        } else {
                                                            if sqlite3_bind_text(statement, 13, ("20220706162438" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                                printSQLiteErrorMsg()
                                                            } else {
                                                                if sqlite3_bind_text(statement, 14, ("54322" as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                                                    printSQLiteErrorMsg()
                                                                } else {
                                                                    if sqlite3_step(statement) == SQLITE_DONE {
                                                                        print("Order Header Saved. Please create corresponding item records.")
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

    func orderDB_CRUD_ReadOrderHeader_byUserID(userID: String) {
        sqlStatement = """
            "SELECT * FROM T_ORDER_H WHERE (ORDERH_USERID = '\(userID)')"
        """
        
        var statement: OpaquePointer?
        
    }
    
    func orderDB_CRUD_ReadOrderHeader_byOrderHID() {}
}
