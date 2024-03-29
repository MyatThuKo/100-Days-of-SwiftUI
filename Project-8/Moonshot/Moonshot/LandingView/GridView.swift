//
//  GridView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 3/15/22.
//

import SwiftUI

struct GridView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let column = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: column) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate ?? "N/A")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        GridView(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
