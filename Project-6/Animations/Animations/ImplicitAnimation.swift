//
//  ContentView.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/5/22.
//

import SwiftUI

struct ImplicitAnimation: View {
    // MARK: - Properties
    @State private var animationAmount = 1.0
    
    // MARK: - Body
    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 2)
        .animation(.default, value: animationAmount)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImplicitAnimation()
    }
}
