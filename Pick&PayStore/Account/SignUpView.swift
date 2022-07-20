//
//  SignUpView.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import SwiftUI
import UIKit
import UserNotifications

struct SignUpView: View {
    
    let lightBlueView = UIColor(red: 153 / 225, green: 214 / 255, blue: 234 / 255, alpha: 1.0)
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirm: String = ""
    
    @State var OTP: Int?
    
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMsg: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(lightBlueView), .white, .white], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 4) {
                Image("people")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                
                Text("Sign Up")
                    .font(.system(size: 35, weight: .bold, design: .default))
                Text("Join the Pick n' Pay Community")
                    .font(.system(size: 17, weight: .semibold, design: .default))
                    .padding(.top)
                VStack {
                    TextField("  First Name", text: $firstName)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                        
                    TextField("  Last Name", text: $lastName)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                        
                    TextField("  Email", text: $email)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                        
                    TextField("  Password (Not required for OTP)", text: $password)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                        
                    TextField("  Re-Enter your Password (Not required for OTP)", text: $passwordConfirm)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                }
                .padding()
                VStack {
                    Button("Sign up") {
                        if inputValidation() {
                            if regexValidation(fname: firstName, lname: lastName, email: email, password: password, password2: passwordConfirm) {
                                if credentialValidtion(email: email) {
                                    createUser()
                                } else {
                                    alertExistingUser()
                                }
                            }
                        }
                    }
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)
                    Text("Don't want to remember another password?")
                    Text("Sign up with a One-Time Password (OTP) instead!")
                    Button("Sign up with OTP") {
                        print("Pressed signup with OTP")
                        myPrint()
                        if inputValidadtionOTP() {
                            if regexValidationOTP(fname: firstName, lname: lastName, email: email) {
                                if credentialValidtion(email: email) {
                                    processOTP()
                                } else {
                                    alertExistingUser()
                                }
                            }
                        }
                    }
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(.orange)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)
                }
            }
        }
        .offset(y: -150)
    }
}


extension UserViewController : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
}


extension SignUpView {
    
    
    func processOTP() {
        sendNotification()
        alertOTP()
    }
    
    func alertOTP() {
        let alert = UIAlertController(title: "OTP Confirmation", message: "Please enter your OTP below", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 1 else {
                return
            }
            let OTPField = fields[0]
            guard let inputedOTP = OTPField.text, !inputedOTP.isEmpty else {
                return
            }
            self.confirmOTP(userOTP: Int(inputedOTP)!)
            
        })
        
        let cancel =  UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { field in
            field.placeholder = "OTP"
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        
        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func confirmOTP(userOTP : Int) {
        
        if(userOTP == OTP!){
            createUserOTP()
            
        } else {
            let wrongOTPAlert = UIAlertController(title: "Incorrect OTP", message: "The OTP you entered was inccorect! Please try again.", preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            
            wrongOTPAlert.addAction(confirm)
            
            let viewController = UIApplication.shared.windows.first!.rootViewController!
            viewController.present(wrongOTPAlert, animated: true, completion: nil)
            
        }
        
    }
    
    func myPrint() {
        print("Pressed signup")
        
        print(firstName)
        print(lastName)
        print(email)
        print(password)
        print(passwordConfirm)
    }
    
    func generateNotification(){
        OTP = Int.random(in: 100000...999999)
        let content = UNMutableNotificationContent()
        content.title = "Pick&Pay Store"
        content.subtitle = "One-Time Password"
        content.body = "Your OTP is \(OTP!)"
        
        let timeInterval = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "OTP", content: content, trigger: timeInterval)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func sendNotification(){
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {notify in
            switch notify.authorizationStatus{
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){ granted, err in
                    if let error = err {
                        print("error in permission")
                    }
                    self.generateNotification()
                }
            case .authorized:
                self.generateNotification()
            case.denied:
                print("permission not graned")
            default:
                print("")
            }
        })
    }
    
    func createUserOTP() {
        print("Create new user")
        DBHelper.dbHelper.saveData(first_Name: firstName, last_Name: lastName, e_email: email, p_password: "", v_verifyPassword: password)
        print("User created. User ID: \(DBHelper.dbHelper.getData(email: email)!.userID)")
        print("User created. User Object id: \(DBHelper.dbHelper.getData(email: email)!.objectID)")
        let alertTitle: String = "Sign up succeeded!"
        alertMsg = "Thank you for signing up Pick n' Pay Store. Please go back to login."
        SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
    }
    
    func createUser() {
        print("Create new user")
        DBHelper.dbHelper.saveData(first_Name: firstName, last_Name: lastName, e_email: email, p_password: password, v_verifyPassword: password)
        print("User created. User ID: \(DBHelper.dbHelper.getData(email: email)!.userID)")
        print("User created. User Object id: \(DBHelper.dbHelper.getData(email: email)!.objectID)")
        let alertTitle: String = "Sign up succeeded!"
        alertMsg = "Thank you for signing up Pick n' Pay Store. Please go back to login."
        SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
    }
    func alertExistingUser() {
        let alertTitle: String = "Existing email found"
        alertMsg = "Your email is registered. Please go back to sign in."
        SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
    }
    
    func credentialValidtion(email: String) -> Bool {
        var credentialValidationPassed: Bool = false
        
        let user: User? = DBHelper.dbHelper.getData(email: email)
        if user == nil {
            credentialValidationPassed = true
        }
        return credentialValidationPassed
    }
    func inputValidadtionOTP() -> Bool {
        var inputValidationPassed: Bool = false
        let alertTitle: String = "Required Field Not Filled"
        var alertMsg: String = ""
        if !validateTextField_NotBlank(text: firstName) {
            alertMsg = "First name cannot be blank. Please try again."
            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
        } else {
            if !validateTextField_NotBlank(text: lastName) {
                alertMsg = "Last name cannot be blank. Please try again."
                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
            } else {
                if !validateTextField_NotBlank(text: email) {
                    alertMsg = "Email cannot be blank. Please try again."
                    SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                } else {
                    inputValidationPassed = true
                }
            }
        }
        return inputValidationPassed
    }
    func inputValidation() -> Bool {
        var inputValidationPassed: Bool = false
        let alertTitle: String = "Required Field Not Filled"
        var alertMsg: String = ""
        if !validateTextField_NotBlank(text: firstName) {
            alertMsg = "First name cannot be blank. Please try again."
            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
        } else {
            if !validateTextField_NotBlank(text: lastName) {
                alertMsg = "Last name cannot be blank. Please try again."
                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
            } else {
                if !validateTextField_NotBlank(text: email) {
                    alertMsg = "Email cannot be blank. Please try again."
                    SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                } else {
                    if !validateTextField_NotBlank(text: password) {
                        alertMsg = "Password cannot be blank. Please try again."
                        SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                    } else {
                        if !validateTextField_NotBlank(text: passwordConfirm) {
                            alertMsg = "Please re-enter your password and try again."
                            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                        } else {
                            inputValidationPassed = true
                        }
                    }
                }
            }
        }
        return inputValidationPassed
    }
    
    func validateTextField_NotBlank(text: String) -> Bool {
        var validationPassed: Bool = true
        if text == "" {
            validationPassed = false
        }
        
        var countOfSpace: Int = 0
        for char in text {
            if char == " " {
                countOfSpace += 1
            }
        }
        if countOfSpace == text.count {
            validationPassed = false
        }
        
        return validationPassed
    }
    
    
    func regexValidationOTP(fname: String, lname: String, email: String) -> Bool {
        let alertTitle: String = "Invalid Input"
        var alertMsg: String = ""
        var regexValidationPassed = false
        
        if !isValidName(name: fname) || !isValidName(name: lname) {
            alertMsg = "Your name should be at least 3 characters."
            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
        } else {
            if !email.isValidEmail {
                print(email == "\(email)")
                print("email.isValidEmail : \(email.isValidEmail)")
                print("email.isValidEmail : \("\(email)".isValidEmail)")
                alertMsg = "Please enter a valid email address."
                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
            } else {
                regexValidationPassed = true
            }
        }
        
        return regexValidationPassed
    }
    
    //validate inputs of fields on signup screen meet regex requirement and update error message accordingly
    func regexValidation(fname: String, lname: String, email: String, password: String, password2: String) -> Bool {
        let alertTitle: String = "Invalid Input"
        var alertMsg: String = ""
        var regexValidationPassed = false
        if !isValidName(name: fname) || !isValidName(name: lname) {
            alertMsg = "Your name should be at least 3 characters."
            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
        } else {
            if !email.isValidEmail {
                print(email == "\(email)")
                print("email.isValidEmail : \(email.isValidEmail)")
                print("email.isValidEmail : \("\(email)".isValidEmail)")
                alertMsg = "Please enter a valid email address."
                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
            } else {
                if !isLongPassword(password: password) {
                    alertMsg = "Please enter a longer password with at least 8 characters."
                    SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                } else {
                    if !isStrongPassword(password: password) {
                        alertMsg = "Please enter a stronger password with at least one uppercase, one lowercase character, one number and one special character (!@#$&*)."
                        SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                    } else {
                        if password != password2 {
                            alertMsg = "Passwords don't match. Please try again."
                            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                        } else {
                            regexValidationPassed = true
                        }
                    }
                }
            }
        }
        return regexValidationPassed
    }
    
    
    func isValidEmail(email : String) -> Bool {
        //print("Email validation: \("xavier@gmail.com".isValidEmail)")
        return email.isValidEmail
    }
    
    func isValidName(name : String) -> Bool {
        var nameIsValid = false
        if name.count >= 3 {
            nameIsValid = true
        }
        return nameIsValid
    }
    
    func isLongPassword(password : String) -> Bool {
        var passwordIsLong = false
        if password.count >= 8 {
            passwordIsLong = true
        }
        return passwordIsLong
    }
    
    func isStrongPassword(password : String) -> Bool {
        var passwordIsStrong = false
        let passwordContainsDigit = regexValidation(value: password, regex: ".*[0-9]+.*")
        let passwordContainsUpperChar = regexValidation(value: password, regex: ".*[A-Z]+.*")
        let passwordContainsLowerChar = regexValidation(value: password, regex: ".*[a-z]+.*")
        let passwordContainsSpecialChar = regexValidation(value: password, regex: ".*[!@#$&*]+.*")
        if passwordContainsDigit && passwordContainsUpperChar && passwordContainsLowerChar && passwordContainsSpecialChar {
            passwordIsStrong = true
        }
        return passwordIsStrong
    }
    
    func regexValidation(value : String, regex : String) -> Bool {
        let validationPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return validationPredicate.evaluate(with: value)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

