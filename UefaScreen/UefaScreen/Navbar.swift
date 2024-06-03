//
//  Navbar.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 31/05/24.
//

import SwiftUI

struct Navbar: View {
    var body: some View {
        NavigationView {
            ScrollView {
                    HStack {
                        Spacer()
                        Text("Presented by")
                            .font(.system(size: 12))
                        Image("visitQatar")
                        Spacer(minLength: 150)
                    }
                    .frame(height: 50)
                        .background(Color(red: 146 / 255, green: 0 / 255, blue: 49 / 255))

                    
                
                    Text("Invite your friends")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .padding(.trailing,170)
                
                Divider().background(Color.white.opacity(0.5)).padding(.horizontal,10)
                
                    Image("euroLeagueCodeImage")
                    .padding()
                
                
                    
                HStack(spacing:30) {
                    
                    ButtonsWithBelowText(imageName: "shareImage", buttonText: "Share to \napps")
                    ButtonsWithBelowText(imageName: "downloadImage", buttonText: "Download \nimage")
                    ButtonsWithBelowText(imageName: "instaImage", buttonText: "Add to \nstory")
                        
                    }
                    .padding()
                
                    Section {
                        ButtonHorizontalAndColored(imageName: "copyContentImage", buttonText: "Copy code")
                        ButtonHorizontalAndColored(imageName: "copyContentImage", buttonText: "Copy auto-join link")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical,5)
                }
            .foregroundStyle(.white)
            .background(Color(red: 0 / 255, green: 13 / 255, blue: 64 / 255))
            .navigationTitle("Leagues")
            .navigationBarColor(backgroundColor: .clear, titleColor: .white)
        }
    }
}

#Preview {
    Navbar()
}
