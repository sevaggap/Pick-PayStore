//
//  CreditCardInfoView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/12/22.
//

import UIKit

class CreditCardInfoView_UIViewController: UIViewController {

    @IBOutlet weak var switch_LoadBAFromSA: UISwitch!
    @IBAction func switch_LoadBAFromSA_ValueChange(_ sender: Any) {
        if switch_LoadBAFromSA.isOn {
            loadBAFromSA()
        } else {
            textFieldBA_Name.text = ""
            textFieldBA_AddressL1.text = ""
            textFieldBA_AddressL2.text = ""
            textFieldBA_Province.text = ""
            textFieldBA_City.text = ""
            textFieldBA_PostalCode.text = ""
            textFieldBA_Country.text = ""
        }
    }
    @IBOutlet weak var textFieldBA_Country: UITextField!
    @IBOutlet weak var textFieldBA_PostalCode: UITextField!
    @IBOutlet weak var textFieldBA_City: UITextField!
    @IBOutlet weak var textFieldBA_Province: UITextField!
    @IBOutlet weak var textFieldBA_AddressL2: UITextField!
    @IBOutlet weak var textFieldBA_AddressL1: UITextField!
    @IBOutlet weak var textFieldBA_Name: UITextField!
    @IBOutlet weak var textFieldCI_ExpDate: UITextField!
    @IBOutlet weak var textFieldCI_SecCode: UITextField!
    @IBOutlet weak var textFieldCI_CardNum: UITextField!
    @IBOutlet weak var textFieldCI_Name: UITextField!
    @IBAction func buttonPlaceOrder(_ sender: Any) {
        if buttonPlaceOrder_DidTouchUpInside_validateCC() && buttonPlaceOrder_DidTouchUpInside_validateAddress() {
            buttonPlaceOrder_DidTouchUpInside_createOrder()
        }
    }
    private var expDatePickerView: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBAFromSA()
        
        //MARK: CONFIGURE PICKERVIEW FOR EXP DATE
        expDatePickerView = UIDatePicker()
        expDatePickerView?.preferredDatePickerStyle = .wheels
        expDatePickerView?.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        
        textFieldCI_ExpDate.inputAccessoryView = toolBar
        textFieldCI_ExpDate.inputView = expDatePickerView
        
    }
    
    @objc func donePressed() {
        //populate date in textfield
        
        let date = expDatePickerView!.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyy"
        let stringYear = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let stringMonth = dateFormatter.string(from: date)
        
        textFieldCI_ExpDate.text = "\(stringYear)/\(stringMonth)"
        //close pickerview
        self.view.endEditing(true)
        
    }
}

extension CreditCardInfoView_UIViewController {
    //MARK: POPULATE BILLING ADDRESS
    func loadBAFromSA() {
        let orderView = OrderView_UIViewController.orderView
        textFieldBA_Name.text = orderView.orderSummarySA.SA_NAME
        textFieldBA_AddressL1.text = orderView.orderSummarySA.SA_ADDRLINE1
        textFieldBA_AddressL2.text = orderView.orderSummarySA.SA_ADDRLINE2
        textFieldBA_Province.text = orderView.orderSummarySA.SA_PROVINCE
        textFieldBA_City.text = orderView.orderSummarySA.SA_CITY
        textFieldBA_PostalCode.text = orderView.orderSummarySA.SA_ZIPCODE
        textFieldBA_Country.text = orderView.orderSummarySA.SA_COUNTRY        
    }
}

extension CreditCardInfoView_UIViewController {
    //MARK: FIELDS VALIDATION - BILLING ADDRESS
    
    func buttonPlaceOrder_DidTouchUpInside_validateAddress() -> Bool {
        var BAIsValid = true
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_Name, isRequired: true)
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_AddressL1, isRequired: true)
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_AddressL2, isRequired: false)
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_Province, isRequired: true)
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_City, isRequired: true)
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_PostalCode, isRequired: true)
        BAIsValid = BAIsValid && textFieldsValidation(textField: textFieldBA_Country, isRequired: true)
        
        print("BAIsValid: \(BAIsValid)")
        return BAIsValid
    }
    //MARK: FIELDS VALIDATION - CARD INFORMATION
    func buttonPlaceOrder_DidTouchUpInside_validateCC() -> Bool {
        var cardInfoIsValid: Bool = true
        
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation(textField: textFieldCI_Name, isRequired: true)
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation(textField: textFieldCI_CardNum, isRequired: true)
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation(textField: textFieldCI_SecCode, isRequired: true)
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation(textField: textFieldCI_ExpDate, isRequired: true)
        cardInfoIsValid = cardInfoIsValid && creditCardValidation_isAllNumber(textField: textFieldCI_CardNum)
        
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation_Length(textField: textFieldCI_CardNum, lengthMin: 15, lengthMax: 16) // amex 15, visa master, discover 16
        
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation_Length(textField: textFieldCI_SecCode, lengthMin: 3, lengthMax: 4) // amex 4, other 3
        
        cardInfoIsValid = cardInfoIsValid && textFieldsValidation_Length(textField: textFieldCI_ExpDate, requiredLength: 7)
        
        cardInfoIsValid = cardInfoIsValid && creditCardValidation_NotExpired(textField: textFieldCI_ExpDate)
        return true
    }
    
    //MARK: CREATE ORDER IN DB AND PRESENT ORDER CONFIRMATION
    func buttonPlaceOrder_DidTouchUpInside_createOrder() {
        let orderView = OrderView_UIViewController.orderView
        let orderSummary = orderView.orderSummary()
        print(orderSummary)
        OrderDBHelper.dbHelper.orderDB_CRUD_CreateOrderHeader(AMOUNT_ITEMS: orderSummary.AMOUNT_ITEMS,
                                                              AMOUNT_SHIPPING: orderSummary.AMOUNT_SHIPPING,
                                                              AMOUNT_TAX: orderSummary.AMOUNT_TAX,
                                                              AMOUNT_GRDTTL: orderSummary.AMOUNT_GRDTTL,
                                                              SA_NAME: orderView.orderSummarySA.SA_NAME,
                                                              SA_ADDRLINE1: orderView.orderSummarySA.SA_ADDRLINE1,
                                                              SA_ADDRLINE2: orderView.orderSummarySA.SA_ADDRLINE2,
                                                              SA_CITY: orderView.orderSummarySA.SA_CITY,
                                                              SA_PROVINCE: orderView.orderSummarySA.SA_PROVINCE,
                                                              SA_ZIPCODE: orderView.orderSummarySA.SA_ZIPCODE,
                                                              SA_COUNTRY: orderView.orderSummarySA.SA_COUNTRY,
                                                              ORDERH_TENDERTYPE: selectedTenderType!)
        CartService.cartServiceInstance.resetCart()
        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
        let orderConfirmationVC = storyboard.instantiateViewController(withIdentifier: "orderConfirmationVC")
        orderConfirmationVC.modalPresentationStyle = .fullScreen
        self.present(orderConfirmationVC, animated: true)
        //navigationController?.pushViewController(orderConfirmationVC, animated: true)
    }
    
    func creditCardValidation_NotExpired(textField: UITextField) -> Bool {
        let regexSeptOrEarlier = "[12][0-9][0-9][0-9][/]0[1-9]"
        let regexOctOrLater = "[12][0-9][0-9][0-9][/]1[0-2]"
        var validationPredicate = NSPredicate(format: "SELF MATCHES %@", regexSeptOrEarlier)
        let expDateIsValid1 = validationPredicate.evaluate(with: textField.text!)
        validationPredicate = NSPredicate(format: "SELF MATCHES %@", regexOctOrLater)
        let expDateIsValid2 = validationPredicate.evaluate(with: textField.text!)
        
        if !(expDateIsValid1 || expDateIsValid2) {
            alert(message: "Invalid expiry date.")
        }
        return expDateIsValid1 || expDateIsValid2
        
    }
    
    func creditCardValidation_isAllNumber(textField: UITextField) -> Bool {
        var isAllNumber = true
        for char in textField.text! {
            let ascii = char.asciiValue!
            if ascii < 48 || ascii > 57 { //out of range of digits
                isAllNumber = false
            }
        }
        
        if !isAllNumber {
            alert(message: "\(textField.placeholder!) should contain digits only.")
        }
        return isAllNumber
    }

    func textFieldsValidation_Length(textField: UITextField, requiredLength: Int) -> Bool {
        var lengthIsValid = false
        let length = textField.text!.count
        
        if length == requiredLength {
            lengthIsValid = true
        }
        
        if !lengthIsValid {
            alert(message: "\(textField.placeholder!) format incorrect.")
        }
        
        return lengthIsValid
    }
    func textFieldsValidation_Length(textField: UITextField, lengthMin: Int, lengthMax: Int) -> Bool {
        var lengthIsValid = false
        let length = textField.text!.count
        if length >= lengthMin && length <= lengthMax {
            lengthIsValid = true
        }
        
        if !lengthIsValid {
            alert(message: "\(textField.placeholder!) should contain \(lengthMin) to \(lengthMax) characters.")
        }
        return lengthIsValid
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
            alert(message: alertMsg)
        }
        
        return textFieldIsValid
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Please check your shipping info.", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
