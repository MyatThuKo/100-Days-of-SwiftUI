//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Myat Thu Ko on 3/5/22.
//

import SwiftUI

struct RegularMaterialBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 10)
    }
}

extension View {
    func RMbackgroundStyle() -> some View {
        modifier(RegularMaterialBackground())
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit))
                                                , y: 0))
    }
}

struct ContentView: View {
    // MARK: - Properties
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "US", "UK", "Poland", "Spain", "Ukarine", "Argentina", "Norway", "Holland"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...3)
    
    @State private var gameStarted = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var scoreCount = 0
    
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 0.25
    @State private var attempts = 0.0
    
    struct FlagImage: View {
        var country: String
        
        var body: some View {
            Image(country)
                .resizable()
                .frame(width: 250, height: 110)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            RadialGradient(stops:
                            [.init(color: Color(red: 0, green: 0.2, blue: 0.7), location: 0.3),
                             .init(color: Color(red: 0.89, green: 0.83, blue: 0), location: 0.3)]
                           , center: .top, startRadius: 400, endRadius: 500)
                .ignoresSafeArea()
            
            Spacer()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                if gameStarted == false {
                    Button {
                        gameStarted.toggle()
                    } label: {
                        Text("Start")
                            .RMbackgroundStyle()
                    }
                } else {
                    VStack(spacing: 15){
                        VStack {
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.heavy))
                                .foregroundColor(.secondary)
                            
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                                .foregroundColor(.primary)
                        }
                        
                        VStack(spacing: 15) {
                            ForEach(0..<4) { number in
                                Button(action: {
                                    flagTapped(number)
                                }) {
                                    FlagImage(country: countries[number])
                                }
                                .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                                .opacity(showingScore && number != correctAnswer ? opacityAmount : 1.0)
                                .modifier(Shake(animatableData: CGFloat(attempts)))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Text("Score: \(scoreCount)")
                            .RMbackgroundStyle()
                        
                        Button {
                            restartGame()
                        } label: {
                            Text("Restart")
                                .RMbackgroundStyle()
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreMessage = "You correctly guessed the flag of \(countries[number])."
            scoreCount += 1
            
            withAnimation {
                animationAmount += 360
            }
        } else {
            scoreTitle = "Incorrect!"
            scoreMessage = "Your guess was the flag of \(countries[number])."
            
            if scoreCount > 0 {
                scoreCount -= 1
            }
            
            withAnimation(.easeIn) {
                opacityAmount = 0.25
                attempts += 1
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
    
    func restartGame() {
        askQuestion()
        scoreCount =  0
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
