//
//  AnimatingBindings.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/5/22.
//

import SwiftUI

struct AnimatingBindings: View {
    // MARK: - Properties
    @State private var animationAmount = 1.0
    
    // MARK: - Body
    var body: some View {
        print(animationAmount)
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 2).repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(30)
            .background(.red)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .scaleEffect(animationAmount)
        }
    }
}

// MARK: - Preview
struct AnimatingBindings_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingBindings()
    }
}
