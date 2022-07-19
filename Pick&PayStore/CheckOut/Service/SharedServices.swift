//
//  SharedServices.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/16/22.
//

import Foundation
import UIKit
enum StoryboardID_CartToPayVC: String {
    case root = "carttopay_root"
    case guestCart = "loginVC"
    case userCart = "carttopay_userCart"
    case emptyCart = "carttopay_emptyCart"
}

enum CellIdentifier_CartToPay: String {
    case userCart = "carttopay_userCartCell"
}

class SharedServices {
    static let service = SharedServices()
    
    
    /// Configure Container View - Full Screen: apply constraints to the container view so that its presentation style is fullscreen
    /// - Parameters:
    ///   - containerView: cotainer/child UIView to be configured
    ///   - parentView: super/parent UIView holding the container view
    func configure_containerViewFullScreen(containerView: UIView, parentView: UIView) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: parentView.bounds.width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: parentView.bounds.height).isActive = true
    }
    
    /// Format Float Values to Strings with Specified Decimal Places
    /// - Parameters:
    ///   - priceVal: price value as a Float
    ///   - currency: currency code or symbol to be returned together with the amount
    ///   - decimalPlaces: decimal places needed for the value
    /// - Returns: Formatted price value with currency code/symbol as a string
    func format_priceValFormatter(priceVal: Float, currency: String, decimalPlaces: Int) -> String {
        return currency + String(format: "%.\(decimalPlaces)f", priceVal)
    }
    /*
     //Multiply the double you want to round by 10^(the number of decimal place precision you want), use the "round()" function, then divide by that number again

     let x = 1.23556789
     let y = Double(round(1000*x)/1000)
     print(y)  // 1.236
     */
    
    func alertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
        }
        alertController.addAction(okAction)
        
        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func currentDate_FormattedForDB() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: Date())
    }
}


extension String {

  var isValidEmail: Bool {
    let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
    let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
    let emailRegEx = name + "@" + domain + "[A-Za-z]{2,8}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: self)
  }

}
