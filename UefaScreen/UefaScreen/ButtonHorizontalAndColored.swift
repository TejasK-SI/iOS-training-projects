//
//  ButtonHorizontalAndColored.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 03/06/24.
//

import SwiftUI

struct ButtonHorizontalAndColored: View {
    var imageName: String?
    var buttonText: String?
    
    var body: some View {
        Button(action: {
            print("Copy code")
        }) {
            HStack {
                Text(buttonText ?? "")
                Spacer()
                Image(imageName ?? "")
            }
            .padding(.horizontal,15)
            .padding(.vertical, 20)
            
            .background(Color(red: 13 / 255, green: 30 / 255, blue: 98 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }}
}

#Preview {
    ButtonHorizontalAndColored()
}
