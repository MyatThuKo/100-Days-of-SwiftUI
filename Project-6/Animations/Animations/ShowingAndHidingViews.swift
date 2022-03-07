//
//  ShowingAndHidingViews.swift
//  Animations
//
//  Created by Myat Thu Ko on 3/6/22.
//

import SwiftUI

struct ShowingAndHidingViews: View {
    // MARK: - Properties
    @State private var isShowingRed = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            Spacer()
            
            if isShowingRed {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .slide, removal: .opacity))
            }
        }
    }
}

// MARK: - Preview
struct ShowingAndHidingViews_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAndHidingViews()
    }
}
