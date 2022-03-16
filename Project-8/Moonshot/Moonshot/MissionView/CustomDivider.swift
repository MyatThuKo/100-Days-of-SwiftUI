//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 3/15/22.
//

import SwiftUI

struct CustomDivider: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

// MARK: - Preview
struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
            .previewLayout(.sizeThatFits)
    }
}
