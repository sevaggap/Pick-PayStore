//
//  LoginValidate.swift
//  P3SignUpLogin
//
//  Created by MAC on 2022-07-06.
//

import Foundation
import UIKit

extension LoginView{

func authenticateUser(email: String, password: String) {
    
    let data = DBHelper.dbHelper.getData()
    var array = [Int]()
    var equivalent : Int = 0
    
    //Checking entered User Info against Core Data Framework
    for user in data{
        
        print(user.email, user.password)
        
        let tempuser = user.email!
        let temppassword = user.password!
        
        if email == tempuser{
            print("Password has yet to be valid. Email matches.")
            if password == temppassword{

                array.append(1)
                showingLoginScreen = true
                print("It's a match")
            } else{

//                result = "Incorrect Password"
                array.append(0)
            }
        }   else{
            
            array.append(0)
            print("Email don't match let alone password")
            print(email, tempuser)
            }
        
        }
        
        //Bitwise XOR
        for a in array{
            equivalent = equivalent^a
        }
    
        //Valid match or not
        if equivalent == 1{
            wrongemail = 0
            wrongpassword = 0
            
            //save to keychain function
            saveKeyChain(theSwitch: theSwitch, email: email, password: password)
            
            //Saving state of the switch
            UserDefaults.standard.set(self.theSwitch, forKey: "Switch")
            
            //view keyChain - put it in viewDidLoad
           
            
        } else{
            wrongemail = 2
            wrongpassword = 2
            result = "Incorrect Email and/or Password"
        }

    }
    
    
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
    
    func viewKeyChain(email : String) -> String{
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
    
    
//    func UserDefault(){
//        if (theSwitch){
//            print("Switch is On")
//            viewKeyChain( email: String)
//        } else{
//            self.email = ""
//            self.password = ""
//        }
//    }
    
    
}
