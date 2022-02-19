//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Myat Thu Ko on 2/18/22.
//
/*
 Challenges
 1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
 2. When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
 3. Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
 */

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...3)
    
    @State private var questionCount = 0
    
    // MARK: - Body
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.45),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.5)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .foregroundColor(.white)
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
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
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
