//
//  ExplicitAnimations.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/5/22.
//

import SwiftUI

struct ExplicitAnimations: View {
    // MARK: - Properties
    @State private var animationAmount = 0.0
    
    // MARK: - Body
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interactiveSpring(dampingFraction: 5, blendDuration: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.black)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 0))
    }
}

// MARK: - Preview
struct ExplicitAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimations()
    }
}
