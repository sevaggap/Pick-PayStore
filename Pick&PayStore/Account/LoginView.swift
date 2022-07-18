//
//  LoginView.swift
//  P3SignUpLogin
//
//  Created by MAC on 2022-07-06.
//

import SwiftUI


struct LoginView: View {
       
        @State var theSwitch = UserDefaults.standard.bool(forKey: "Switch")
        @State var lastUser = UserDefaults.standard.value(forKey: "Email")
        @State var switchState = false

        @State internal var email : String = ""
        @State internal var password : String = ""
        @State internal var wrongemail = 0
        @State internal var wrongpassword = 0
        @State internal var showingLoginScreen = false
        @State internal var passwordforUserDefault : String?
        
        @State internal var result = ""

        
        var body: some View {
            
            NavigationView{
                
                ZStack{
                    Circle()
                        .scale(1.7)
                        .foregroundColor(.white)
                
            VStack{
                
               
                
                Text(result).foregroundColor(.red)
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(.yellow)
                        .padding(5)
                    
                    //Email`$`
                    TextField("E-mail", text: $email)
                        .frame(width: 250, height: 50)
                   
                }
                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                .background(Color.black.opacity(0.05))
                .border(.red, width: CGFloat(wrongemail))
                .offset(y: -5)
                
                //Password
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(.yellow)
                        .padding(5)
                    SecureField("Password", text: $password)
                    .frame(width: 250, height: 50)
                    
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                .background(Color.black.opacity(0.05))
                .border(.red, width: CGFloat(wrongpassword))
                
                
                //Remember Me
                Toggle("Remember Me", isOn: $switchState)
                .frame(width: 180, height: 25, alignment: .center)
                .offset(y: 10)
                .onChange(of: switchState){ value in
                    
                    if switchState{
                        
                        UserDefaults.standard.set(email, forKey: "Email")
                        UserDefaults.standard.set(true, forKey: "Switch")
                        print(UserDefaults.standard.value(forKey : "Email"))
                        print(UserDefaults.standard.value(forKey : "Switch"))
                    } else {
                        UserDefaults.standard.set(nil, forKey: "Email")
                        UserDefaults.standard.set(false, forKey: "Switch")
                        print(UserDefaults.standard.value(forKey : "Email"))
                        print(UserDefaults.standard.value(forKey : "Switch"))
                    }

                    
                }
                
                //Login Button
                HStack{
                    Button(action: {
                        authenticateUser(email: email, password: password)
                    }, label: {
                    Text("Login")
                            .frame(width: 110, height: 60)
                            .foregroundColor(.yellow)
                    })
                    
                    NavigationLink(destination: Shopping(), isActive: $showingLoginScreen){
                        
                    }
                    
                    //Creating a link
                  
                    NavigationLink(destination: SignUpView()) {
                        Text("SignUp")
                            .frame(width: 150, height: 60)
                                      .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                                        .foregroundColor(.white)
                    }   //NAVIGATION LINK
                }//H-STACK
            .offset(y: 20)
                Text("Need a better way to login?")
                    
                NavigationLink(destination: otpLogin()) {
                        Text("Login with OTP")
                            .frame(width: 150, height: 60)
                                      .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                                        .foregroundColor(.white)
                    }
                
        }//V-STACK
            .offset(y: -100)
        }.onAppear{         //Z-STACK
            switchState = UserDefaults.standard.bool(forKey : "Switch")
            print(switchState)
            if (switchState == true ){
                email = UserDefaults.standard.string(forKey : "Email")!
//                    print(" Switch is On: \(UserDefaults.standard.value(forKey: "Email"))")
                
                password = viewKeyChain(email : email)
            } else{
                print("No calling")
            }
            
            }//ON-APPEAR
        }//NAVIGATION-VIEW
            
    }//BODY
}





struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
