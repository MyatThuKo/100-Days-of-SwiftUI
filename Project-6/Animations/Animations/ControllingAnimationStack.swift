//
//  ControllingAnimationStack.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/5/22.
//

import SwiftUI

struct ControllingAnimationStack: View {
    // MARK: - Properties
    @State private var enabled = false
    
    // MARK: - Body
    var body: some View {
        Button("Hit me!") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .foregroundColor(.black)
        .background(enabled ? .red : .blue)
        .animation(.default, value: enabled)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 70 : 30))
        .animation(.interactiveSpring(response: 1, dampingFraction: 2, blendDuration: 1), value: enabled)
    }
}

// MARK: - Preview
struct ControllingAnimationStack_Previews: PreviewProvider {
    static var previews: some View {
        ControllingAnimationStack()
    }
}
