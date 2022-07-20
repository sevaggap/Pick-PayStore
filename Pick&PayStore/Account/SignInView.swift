//
//  SignInView.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import SwiftUI

struct SignInView: View {
    
    let lightBlueView = UIColor(red: 153 / 225, green: 214 / 255, blue: 234 / 255, alpha: 1.0)
    
    
    @State var email: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = true
    @State var keepSession: Bool = true
    
    @State var OTP: Int?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(lightBlueView), .white, .white], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 4) {
                VStack {
                    Image("login")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    Text("Sign In")
                        .font(.system(size: 35, weight: .bold, design: .default))
                    Text("To place an order & access order history")
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .padding(.top)
                }
                
                VStack{

                    TextField("  Email", text: $email)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                    SecureField("  Password (Not required for OTP)", text: $password)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 340, height: 30, alignment: .center)
                        .border(.gray, width: 2)
                        .cornerRadius(5)
                }
                .padding()
                
                VStack{
                    Toggle("Save my password", isOn: $rememberMe)
                        .frame(width: 210, height: 40, alignment: .center)
                    Toggle("Keep me logged in", isOn: $keepSession)
                        .frame(width: 210, height: 40, alignment: .center)
                }
                .padding()
                
                VStack {
                    Button("Login") {
                        print("Pressed signin")
                        login()
                    }
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)

                    
                    Text("Want a faster way to login?")
                    
                    Button("Login with OTP") {
                        print("Pressed signin with OTP")
                        loginOTP()
                    }
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(.orange)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)
                }
            }
            .offset(y: -150)
            .onAppear(perform: {
                print("viewDidLoad")
                populateCredentials()
            })
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
        }
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
        if keepSession {
            rememberMe = true
        }
        let userDefault = UserDefaults.standard
        userDefault.set(email, forKey: "lastUser")
        userDefault.set(rememberMe, forKey: "lastUserSwitchedOnRememberMe")
        userDefault.set(keepSession, forKey: "lastUserSwitchedOnKeepLogin")
        print(userDefault.string(forKey: "lastUser"))
        print(userDefault.bool(forKey: "lastUserSwitchedOnRememberMe"))
        print(userDefault.bool(forKey: "lastUserSwitchedOnKeepLogin"))
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
