//
//  ContentView.swift
//  WeSplit
//
//  Created by Myat Thu Ko on 2/14/22.
//

/*
 Challenge
 1. Add a header to the third section, saying "Amount per person"
 2. Add another section showing the total amount for the check (including tip)
 3. Change tip percentage selection from a segamented control to a regular one and add more selections
 */

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    // let tipPercentages = [15, 18, 20, 25, 0]
    
    var total: [Double] {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return [grandTotal, amountPerPerson]
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    /*
                     // Segmented Control
                     Picker("Tip Percentage", selection: $tipPercentage) {
                         ForEach(tipPercentages, id: \.self) {
                             Text($0, format: .percent)
                         }
                     }
                     .pickerStyle(.segmented)
                     */
                    // MARK: - Challenge 3
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip would you like to leave? ")
                }
                
                Section {
                    Text(total[1], format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    // MARK: - Challenge 1
                    Text("Amount Per Person")
                }
                
                // MARK: - Challenge 3
                Section {
                    Text(total[0], format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header : {
                    Text("Grand Total")
                }
                
            }
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
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
