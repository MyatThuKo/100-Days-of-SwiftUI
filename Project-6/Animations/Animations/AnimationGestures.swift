//
//  AnimationGestures.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/6/22.
//

import SwiftUI

struct AnimationGestures: View {
    // MARK: - Properties
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmountOne = CGSize.zero
    @State private var dragAmountTwo = CGSize.zero
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmountTwo)
                        .animation(.default.delay(Double(num) / 20), value: dragAmountTwo)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmountTwo = $0.translation }
                    .onEnded { _ in
                        dragAmountTwo = .zero
                        enabled.toggle()
                    }
            )
            
            Spacer()
            
            LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmountOne)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmountOne = $0.translation }
                        .onEnded { _ in dragAmountOne = .zero}
                )
            .animation(.spring(), value: dragAmountOne)
        }
    }
}

// MARK: - Preview
struct AnimationGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGestures()
    }
}
