//
//  UserView.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import SwiftUI

struct UserView: View {
    //184222236
    let lightBlueApp = UIColor(named: "lightBlue")!.cgColor
    
    let lightBlueView = UIColor(red: 153 / 225, green: 214 / 255, blue: 234 / 255, alpha: 1.0)
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(lightBlueView), .white, .white], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                        .frame(width: 150, height: 80, alignment: .center)
                    VStack {
                        Text("Taking advantage of Pick n' Pay perks is just a step away!")
                            .font(.system(size: 21, weight: .bold, design: .default))
                            .frame(width: 350, height: 100, alignment: .center)
                            .multilineTextAlignment(.center)
                            .padding(15)
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .frame(width: 200, height: 40, alignment: .center)
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .cornerRadius(10)
                                .padding(.top)
                        }
                        NavigationLink(destination: SignInView()) {
                            Text("Sign In")
                                .frame(width: 200, height: 40, alignment: .center)
                                .background(.orange)
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .cornerRadius(10)
                                .padding(.top)
                        }
                    }

                    VStack(spacing: 25) {
                        LogInFeatureView(imageName: "open-box", featureDesc: "Check order status and track, change, or return items.")
                        LogInFeatureView(imageName: "online-shopping", featureDesc: "Shop past purchases and everyday essentials.")
                        LogInFeatureView(imageName: "list", featureDesc: "Add faviroute items to cart, now or later")
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

struct LogInFeatureView: View {
    
    var imageName: String
    var featureDesc: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding()
            Text(featureDesc)
                .font(.system(size: 15, weight: .bold, design: .default))
                .frame(width: 210, height: 80, alignment: .center)
                .padding()
        }
    }
}
