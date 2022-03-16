//
//  ListView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 3/15/22.
//

import SwiftUI

struct ListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text(mission.formattedLaunchDate ?? "N/A")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
        }
        .listStyle(.plain)
    }
}

struct ListView_Previews: PreviewProvider {
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
