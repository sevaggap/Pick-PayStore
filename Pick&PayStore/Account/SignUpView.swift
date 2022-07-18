//
//  SignUpView.swift
//  P3SignUpLogin
//
//  Created by MAC on 2022-07-06.
//

import SwiftUI

struct SignUpView: View {
        
        @State var firstName : String = ""
        @State var lastName : String = ""
        @State var emailAddress : String = ""
        @State var passwordValue : String = ""
        @State var wrongPasswordValue : String = ""
        
        var body: some View {
               
            ZStack{
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                
                    VStack{
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(.yellow)
                                .padding(5)
                            
                            //First Name
                            TextField("First Name", text: $firstName)
                                .frame(width: 250, height: 25)
                           
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                        
                        
                        
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(.yellow)
                                .padding(5)
                            
                            //Last Name
                            TextField("Last Name", text: $lastName)
                                .frame(width: 250, height: 25)
                           
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                        .offset(y: 5)
                        
                        
                        
                        HStack{
                            Image(systemName: "envelope")
                                .foregroundColor(.yellow)
                                .padding(5)
                            
                            //Email
                            TextField("Email", text: $emailAddress)
                                .frame(width: 250, height: 25)
                           
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                        .offset(y: 10)
                        
                        
                        //Password
                        HStack{
                            Image(systemName: "lock")
                                .foregroundColor(.yellow)
                                .padding(5)
                            
                            
                            TextField("Password", text: $passwordValue)
                            .frame(width: 250, height: 25)
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                        .offset(y: 15)
                        
                        //Verify Password
                        HStack{
                            Image(systemName: "lock")
                                .foregroundColor(.yellow)
                                .padding(5)
                            
                    TextField("Verify Password", text: $wrongPasswordValue)
                            .frame(width: 250, height: 25)
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.yellow, lineWidth: 1))
                        .offset(y: 20)
                 
                        //Register Button
                        HStack{
                          
                            Button(action: {
                                //Email specification
                                let emailPattern = #"^\S+@\S+\.\S+$"#
                                var emailResult = emailAddress.range(of: emailPattern,
                                                                     options: .regularExpression)
                                let validEmail = (emailResult != nil)
                                
                                //Password specification
                                let passwordPattern = #"(?=.{8,})"# +     //At least 8 characters
                                #"(?=.*[A-Z])"# +                         //At least one capital letter
                                #"(?=.*[a-z])"# +                         //At least one lower case letter
                                #"(?=.*\d)"# +                            //At least one digit
                                #"(?=.*[!$%&?._-])"#                      //At least one special character
                                
                                var passwordResult = passwordValue.range(of: passwordPattern,                                               options: .regularExpression)
                                
                                var validPassword = (passwordResult != nil)
                                
                                //Sign-Up Validation
                                if ( firstName.count > 4 && lastName.count > 4 && passwordValue == wrongPasswordValue && validEmail && validPassword){
                                    
                                    DBHelper.dbHelper.saveData(first_Name: firstName, last_Name: lastName, e_email: emailAddress, p_password: passwordValue, v_verifyPassword: wrongPasswordValue)
                                } else{
                                    print("First and Last Name must be more than 4 characters. Email must be correct format with @ sign. Pasword must contain 8 characters and they must match.")
                                }
                                
                            }, label:{
                        Text("Register")
                            
                        .frame(width: 150, height: 30)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                         .foregroundColor(.white)
                      
                            })
                        }
                    .offset(y: 30)

                }.offset(y: -100)
            }
          
    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


