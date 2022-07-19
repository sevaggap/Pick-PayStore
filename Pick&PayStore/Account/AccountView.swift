//
//  AccountView.swift
//  P3SignUpLogin
//
//  Created by MAC on 2022-07-07.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        
        NavigationView{
        VStack{
            
            Label("Sign in for the best experience", systemImage: "")
            
            NavigationLink(destination: LoginView()) {
                Text("Login")
                    .frame(width: 150, height: 60)
                              .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                                .foregroundColor(.white)
            }
            
            NavigationLink(destination: SignUpView2()) {
                Text("Create Account")
                    .frame(width: 150, height: 60)
                              .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                                .foregroundColor(.white)
            }
            
            //Item 1
            NavigationLink(destination: Shopping()) {
                Text("Check order status and track, change or return items")
                    .frame(width: 300, height: 60)
                              .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
                                .foregroundColor(.white)
            }

            
            //Item 2
            NavigationLink(destination: Shopping()) {
                Text("Shop past purchases and everyday essentials")
                    .frame(width: 300, height: 60)
                              .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
                                .foregroundColor(.white)
            }

            
            //Item 3
            NavigationLink(destination: Shopping()) {
                Text("Create lists with items you want, now or later")
                    .frame(width: 300, height: 60)
                              .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
                                .foregroundColor(.white)
            }

        }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}