//
//  AstronautView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 3/15/22.
//

import SwiftUI

struct AstronautView: View {
    // MARK: - Properties
    let astronaut: Astronaut
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct AstronautView_Previews: PreviewProvider {
    static let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaut["armstrong"]!)
            .preferredColorScheme(.dark)
    }
}
