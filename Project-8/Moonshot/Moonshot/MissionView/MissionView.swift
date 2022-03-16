//
//  MissionView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 3/15/22.
//

import SwiftUI

struct MissionView: View {
    // MARK: - Properties
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text("Launch Date")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(mission.longLaunchDate)
                        .font(.title.bold().italic())
                    
                    VStack(alignment: .leading) {
                        CustomDivider()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        CustomDivider()
                        
                        Text("Crew Members")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewMembersView(mission: mission, astronauts: astronauts)
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
}

// MARK: - Preview
struct MissionView_Previews: PreviewProvider {
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: mission[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
