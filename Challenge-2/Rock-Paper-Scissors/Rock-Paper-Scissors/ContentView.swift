//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Myat Thu Ko on 2/21/22.
//

import SwiftUI

struct RegularMaterialBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func viewStyle() -> some View {
        modifier(RegularMaterialBackground())
    }
}

struct ContentView: View {
    // MARK: - Properties
    let gameChoices = ["🪨", "📄", "✂️"]
    
    @State private var userChoice = ""
    @State private var computerChoice = ""
    
    @State private var winCount = 0
    @State private var lossCount = 0
    @State private var tieCount = 0
    @State private var gameCount = 0
    @State private var gameStatus = ""
    
    @State private var startGame = false
    @State private var showAlert = false
    
    struct GameIcon: View {
        var icon: String
        
        var body: some View {
            Text(icon)
                .font(.system(size: 45))
                .viewStyle()
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.95, green: 0.23, blue: 0.33), location: 0.3),
                .init(color: Color(red: 0.14, green: 0.33, blue: 0.9), location: 0.9)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("Rock, Paper and Scisscors")
                    .viewStyle()
                
                if !startGame {
                    Spacer()
                    Button {
                        startGame.toggle()
                    } label: {
                        Text("Start Game")
                            .viewStyle()
                    }
                } else {
                    HStack {
                        ForEach(gameChoices, id: \.self) {icon in
                            Button {
                                playGame(userChoice: icon)
                            } label: {
                                GameIcon(icon: icon)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if !userChoice.isEmpty {
                        VStack {
                            VStack(spacing: 15) {
                                Text("Round \(gameCount)")
                                Text("You chose - \(userChoice)")
                                Text("Computer chose - \(computerChoice)")
                                Text("You \(gameStatus)!")
                            }
                            .font(.title2)
                            .viewStyle()
                        }
                        Button {
                            showAlert.toggle()
                        } label: {
                            Text("Restart Game")
                                .font(.headline)
                                .viewStyle()
                            
                        }
                    }
                }
            }
        }
        .alert("\(gameCount) games completed!", isPresented: $showAlert) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Game won: \(winCount) \n Game lost: \(lossCount) \n Game tied: \(tieCount)")
        }
    }
    
    func restartGame() {
        startGame = false
        winCount = 0
        lossCount = 0
        tieCount = 0
        gameCount = 0
        userChoice = ""
    }
    
    func playGame(userChoice user: String) {
        gameCount += 1
        let computer = gameChoices.randomElement()
        computerChoice = computer!
        userChoice = user
        
        if user == computer {
            gameStatus = "Tie"
        } else if user == "🪨" {
            if computer == "📄" {
                gameStatus = "Lose"
            } else {
                gameStatus = "Win"
            }
        } else if user == "📄" {
            if computer == "✂️" {
                gameStatus = "Lose"
            } else {
                gameStatus = "Win"
            }
        } else {
            if computer == "🪨" {
                gameStatus = "Lose"
            } else {
                gameStatus = "Win"
            }
        }
        
        if gameStatus == "Win" {
            winCount += 1
        } else if gameStatus == "Lose" {
            lossCount += 1
        } else {
            tieCount += 1
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
