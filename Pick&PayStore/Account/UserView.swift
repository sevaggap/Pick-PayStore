//
//  UserView.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import SwiftUI

struct UserView: View {
    
    var body: some View {

        ZStack {
            
            NavigationView {
                VStack {
                    Text("Taking advantage of Pick n' Pay perks is just a step away!")
                        .fontWeight(.heavy)
                        .font(.system(size: 21, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .frame(width: 240, height: 49, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    
                    NavigationLink(destination: SignInView()) {
                        Text("Sign In")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .frame(width: 240, height: 49, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                    
                    VStack {
                        HStack {
                            
                            Image("open-box")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .cornerRadius(10)
                                .padding(.vertical, 30)
                            Text("Check order status and track, change, or return items.")
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .padding()
                            
                        }
                        HStack {
                            
                            Image("online-shopping")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .cornerRadius(10)
                                .padding(.vertical, 30)
                            Text("Shop past purchases and everyday essentials.")
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .padding()
                            
                        }
                        HStack {
                            Image("list")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .cornerRadius(10)
                                .padding(.vertical, 30)
                            Text("Create lists with items you want, now or later")
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .padding()
                        }
                        
                    }
                    
                }
                .offset(y: -150)
            }
            
        }
        .background(.ultraThinMaterial)
    }
        
        
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
