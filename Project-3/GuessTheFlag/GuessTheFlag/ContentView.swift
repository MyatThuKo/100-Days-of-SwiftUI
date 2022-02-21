//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Myat Thu Ko on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...3)
    
    @State private var questionCount = 0
    
    struct FlagImage: View {
        var country: String
        
        var body: some View {
            Image(country)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 10)
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.7, green: 0.82, blue: 0.5), location: 0.55),
                .init(color: Color(red: 0.25, green: 0.2, blue: 0.2), location: 0.55)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .foregroundColor(Color(red: 0.25, green: 0.2, blue: 0.2))
                    .font(.largeTitle.bold())
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<4) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Question Number: \(questionCount + 1)")
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()
                
                HStack {
                    Text("Score: \(currentScore)")
                        .padding(15)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Button {
                        restartScore()
                    } label: {
                        Text("Restart")
                            .foregroundColor(.black)
                            .padding(15)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCount < 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: restartScore)
            }
        } message: {
            if questionCount < 8 {
                Text("Your score is \(currentScore).")
            } else {
                Text("Your final score is \(currentScore).")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            currentScore += 1
        } else {
            scoreTitle = "Incorrect! That's the flag of \(countries[number])..."
            if currentScore > 0 {
                currentScore -= 1
            }
        }
        
        questionCount += 1
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
    
    func restartScore() {
        questionCount = 0
        currentScore = 0
        askQuestion()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
