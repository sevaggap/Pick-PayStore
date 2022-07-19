//
//  SignInView.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = true
    
    @State var OTP: Int?
    
    var body: some View {
        
        VStack {
            Image("login")
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .cornerRadius(10)
                .padding(.vertical, 30)
            Text("Login to Place an Order & Access Order History")
                .fontWeight(.heavy)
                .font(.system(size: 21, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            HStack {
                Spacer()
                VStack {
                    TextField("Email", text: $email)
                        .padding()
                    TextField("Password (Not required for OTP)", text: $password)
                        .padding()
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Toggle("Remember Me", isOn: $rememberMe)
                    .padding()
                Spacer()
            }
            
            Button("Login") {
                print("Pressed signin")
                login()
            }
            .padding()
            Text("Want a faster way to login?")
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .padding()
            Button("Login with OTP") {
                print("Pressed signin with OTP")
                loginOTP()
            }
            .padding()
        }
        .offset(y: -150)
        .onAppear(perform: {
            print("viewDidLoad")
            populateCredentials()
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


extension SignInView {
    func login() {
        let user: User?
        var alertTitle: String = ""
        var alertMsg: String = ""
        
        if !inputValidation(text: email) {
            alertTitle = "Required Field Not Filled"
            alertMsg = "Email cannot be blank. Please try again."
            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
        } else {
            if !inputValidation(text: password) {
                alertMsg = "Password cannot be blank. Please try again."
                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
            } else {
                if !regexValidation(email: email) {
                    alertTitle = "Invalid Input"
                    alertMsg = "Please enter a valid email address."
                    SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                } else {
                    user = DBHelper.dbHelper.getData(email: email)
                    if user == nil {
                        alertTitle = "Email Address Not Found"
                        alertMsg = "This email address is not registered yet. Please sign up first."
                        SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                    } else {
                        if user!.password == "" {
                            alertTitle = "Invalid Login Option"
                            alertMsg = "You signed up with OTP; please choose Login with OTP below."
                            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                        } else {
                            if user!.password != password {
                                alertTitle = "Password Incorrect"
                                alertMsg = "Please check your password and try again."
                                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                            } else {
                                loginComplete()
                            }
                        }
                    }
                }
                
            }
        }
        
        
    }
    func loginOTP() {
        var user: User?
        var alertTitle: String = ""
        var alertMsg: String = ""
        
        if !inputValidation(text: email) {
            alertTitle = "Required Field Not Filled"
            alertMsg = "Email cannot be blank. Please try again."
            SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
        } else {
            
            if !regexValidation(email: email) {
                alertTitle = "Invalid Input"
                alertMsg = "Please enter a valid email address."
                SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
            } else {
                user = DBHelper.dbHelper.getData(email: email)
                if user == nil {
                    alertTitle = "Email Address Not Found"
                    alertMsg = "This email address is not registered yet. Please sign up first."
                    SharedServices.service.alertMessage(title: alertTitle, message: alertMsg)
                } else {
                    sendNotification()
                    alertOTP()
                }
            }
        }
        
    }
    func regexValidation(email: String) -> Bool {
        var isValid: Bool = false
        isValid = email.isValidEmail
        return isValid
    }
    
    func inputValidation(text: String) -> Bool {
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
            loginComplete()
            
        } else {
            let wrongOTPAlert = UIAlertController(title: "Incorrect OTP", message: "The OTP you entered was inccorect! Please try again.", preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            
            wrongOTPAlert.addAction(confirm)
            
            let viewController = UIApplication.shared.windows.first!.rootViewController!
            viewController.present(wrongOTPAlert, animated: true, completion: nil)
            
        }
        
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
    
    func loginComplete() {
        print("loginComplete")
        //update User default
        let userDefault = UserDefaults.standard
        userDefault.set(email, forKey: "lastUser")
        userDefault.set(rememberMe, forKey: "lastUserSwitchedOnRememberMe")
        print(userDefault.string(forKey: "lastUser"))
        print(userDefault.bool(forKey: "lastUserSwitchedOnRememberMe"))
        // - remember me
        if rememberMe {
            print("Remember me is on. Processing")
            saveKeyChain(theSwitch: rememberMe, email: email, password: password)
        }
        // - update logged in status & current user
        LoginStatus.status.isLoggedIn = true
        LoginStatus.status.currentUser = DBHelper.dbHelper.getData(email: email)
        // - present loggedin page
        
        //FIXME: present loggedin page
        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "orderHistoryVC")
        vc.modalPresentationStyle = .fullScreen
        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func populateCredentials() {
        //read userdefault
        let userDefault = UserDefaults.standard
        let rememberLastUser = userDefault.bool(forKey: "lastUserSwitchedOnRememberMe")
        let emailLastUser = userDefault.string(forKey: "lastUser")
        
        if rememberLastUser {
            
            email = (emailLastUser != nil) ? emailLastUser! : ""
            //read keychain & auto fill text fields
            password = viewKeyChain(email: (emailLastUser != nil) ? emailLastUser! : "")
            print(password)
        } else {
            email = ""
            password = ""
        }
    }
}
