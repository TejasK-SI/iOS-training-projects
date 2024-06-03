//
//  ButtonsWithBelowText.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 03/06/24.
//

import SwiftUI

struct ButtonsWithBelowText: View {
    
    var imageName: String?
    var buttonText: String?
    var body: some View {
        
        
        Button(action: {
            print("Share to apps")
        }) {
            VStack {
                Image(imageName ?? "")
                Text(buttonText ?? "")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
            }}
    }
}

#Preview {
    ButtonsWithBelowText()
}
