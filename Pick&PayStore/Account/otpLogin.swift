//
//  otpLogin.swift
//  P3SignUpLogin
//
//  Created by MAC on 2022-07-18.
//

import SwiftUI

struct otpLogin: View {
    
    @State internal var phoneNumber : String = ""
    
    var body: some View {
        VStack{
            //Title
            Text("OTP Login")
            
            //Taking phone number as Input
            TextField("Phone Number", text: $phoneNumber)
                .frame(width: 250, height: 50)
            
            //Generating OTP Button
            Button(action: {
                UNUserNotificationCenter.current().getNotificationSettings{ notify in
                    
                    switch notify.authorizationStatus{
                    case .notDetermined:
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ granted, err in
                            if let error = err{
                                print("error in permission", error)
                            }
                            self.generateNotification()
                        }
                        
                    case .authorized:
                        self.generateNotification()
                    case .denied:
                        print("permission not given")
                    default:
                        print("")
                    }
                }
            }, label: {
            Text("Generate OTP")
                    .frame(width: 110, height: 60)
                    .foregroundColor(.yellow)
            })
            
        }.onAppear{
            
            //UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
                  
        }
    }//Body View closing Parntheses
    
    
    func generateNotification(){
        let content = UNMutableNotificationContent()
        content.title = "New Msg"
        content.subtitle = "from TakeItEasy App"
        content.body = "Your OTP is 7860"
        
        let timeInterval = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: "User_App_Notification", content: content, trigger: timeInterval)
        UNUserNotificationCenter.current().add(request){_ in
            
            
        }
        
    }//Function closing parentheses
}

struct otpLogin_Previews: PreviewProvider {
    static var previews: some View {
        otpLogin()
    }
}
