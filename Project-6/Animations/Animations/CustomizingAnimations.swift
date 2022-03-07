//
//  CustomizingAnimations.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/5/22.
//

import SwiftUI

struct CustomizingAnimations: View {
    // MARK: - Properties
    @State private var tapAnimationAmount = 1.0
    @State private var overlayAnimationAmount = 1.0
    
    // MARK: - Body
    var body: some View {
        VStack {
            Button("Tap Me") {
                tapAnimationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.black)
            .clipShape(Circle())
            .scaleEffect(tapAnimationAmount)
            .animation(.easeInOut(duration: 3).repeatCount(3, autoreverses: true), value: tapAnimationAmount)
            
            Spacer()
            
            Button("Overlay") {
                // do nothing
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red)
                    .scaleEffect(overlayAnimationAmount)
                    .opacity(2 - overlayAnimationAmount)
                    .animation(
                        .easeOut(duration: 1).repeatForever(autoreverses: false),
                        value: overlayAnimationAmount
                    )
            )
            
            Spacer()
        }
        .onAppear {
            overlayAnimationAmount = 2
        }
    }
}

// MARK: - Preview
struct CustomizingAnimations_Previews: PreviewProvider {
    static var previews: some View {
        CustomizingAnimations()
    }
}
