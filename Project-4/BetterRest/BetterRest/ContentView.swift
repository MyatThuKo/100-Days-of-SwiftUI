//
//  ContentView.swift
//  BetterRest
//
//  Created by Myat Thu Ko on 2/25/22.
//
/*
 Challenges
 1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
 2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
 3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
 */

import CoreML
import SwiftUI

struct Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.primary)
    }
}

extension View {
    func headlineStyle() -> some View {
        modifier(Headline())
    }
}

struct ContentView: View {
    // MARK: - Properties
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var recommendedBedTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Error 404! Couldn't be calculated!"
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Image("BetterRest")
                .resizable()
                .frame(width: 400, height: 400, alignment: .center)
            
            VStack(alignment: .center, spacing: 50) {
                
                Text("Better Rest")
                    .font(.system(size: 65).bold())
                    .foregroundColor(.brown)
                    .rotation3DEffect(.degrees(25), axis: (x: 1, y: 0, z: 0))
                    .shadow(color: .brown, radius: 2, x: 0, y: 15)
                
                Spacer()
                
                VStack(spacing: 5) {
                    Text("Recommended Bed Time")
                        .headlineStyle()
                    
                    Text(recommendedBedTime)
                        .foregroundColor(.init(Color(red: 0.85, green: 0.15, blue: 0.25)))
                        .font(.largeTitle.bold())
                }
                
                Spacer()
                Spacer()
                
                VStack {
                    Text("When do you want to wake up?")
                        .headlineStyle()
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                HStack(spacing: 50) {
                    Text("Daily Coffee Intake")
                        .headlineStyle()
                    
                    Picker("", selection: $coffeeAmount) {
                        ForEach(1..<21) { amount in
                            Text(amount == 1 ? "1 cup" : "\(amount) cups")
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
