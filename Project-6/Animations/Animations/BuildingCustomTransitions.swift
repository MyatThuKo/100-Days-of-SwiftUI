//
//  BuildingCustomTransitions.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/6/22.
//

import SwiftUI

struct CornerRotateModifer: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifer(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifer(amount: 0, anchor: .topLeading))
    }
}

struct BuildingCustomTransitions: View {
    // MARK: - Properties
    @State private var isShowingRed = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

// MARK: - Preview
struct BuildingCustomTransitions_Previews: PreviewProvider {
    static var previews: some View {
        BuildingCustomTransitions()
    }
}
