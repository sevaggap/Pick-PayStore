//
//  KeyChainHelper.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/19/22.
//

import Foundation

extension SignInView {
    
    func saveKeyChain(theSwitch: Bool, email: String, password : String){
        
        //saving to keychain
        if (theSwitch) {
            
            //save the user info to keychain when switch is on
            let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : email, kSecValueData as String : password.data(using: .utf8)]
            
            if SecItemAdd(attribute as CFDictionary, nil) == noErr{
                print("User Info Saved Successfully")
            } else{
                print("Error in saving User Info or User already exists in KeyChain")
            }
            
        } else{
            print("Switch is off, no need to save to keychain")
        }
        
    }
    
    func viewKeyChain(email : String) -> String {
        let req: [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : email, kSecReturnAttributes as String: true, kSecReturnData as String: true]
        
        var pass = ""
        
        var res : CFTypeRef?
        if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
            let data = res as? [String : Any]
            let email_id = data![kSecAttrAccount as String] as? String
            let password_id = (data![kSecValueData as String] as? Data)!
            
            pass = String(data: password_id, encoding: .utf8)!
            
            print("email is:", email_id,",password is:", pass)
            
        } else{
            print("Error in retrieving data from keyChain")
        }
        
        return pass
    }
}
