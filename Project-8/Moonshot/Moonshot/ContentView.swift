//
//  ContentView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 3/14/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationBarItems(
                trailing:
                    Button(showingGrid ? "Show List" : "Show Grid") {
                        showingGrid.toggle()
                    }
            )
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
