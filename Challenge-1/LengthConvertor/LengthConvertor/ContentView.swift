//
//  ContentView.swift
//  LengthConvertor
//
//  Created by Myat Thu Ko on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var userInput = 0.0
    @State private var inputUnit = "m"
    @State private var outputUnit = "km"
    
    let unitLength = ["m", "km", "ft", "yd", "mi"]
    
    var output: String {
        let from = inputUnit
        let to = outputUnit
        
        var inputUnitLength = UnitLength.meters
        var outputUnitLength = UnitLength.kilometers
        
        if from == "mi" {
            inputUnitLength = UnitLength.miles
            
            switch to {
            case "m":
                outputUnitLength = UnitLength.miles
            case "ft":
                outputUnitLength = UnitLength.feet
            case "yd":
                outputUnitLength = UnitLength.yards
            case "mi":
                outputUnitLength = UnitLength.miles
            default:
                outputUnitLength = UnitLength.kilometers
            }
        } else if from == "km" {
            inputUnitLength = UnitLength.kilometers
            
            switch to {
            case "m":
                outputUnitLength = UnitLength.miles
            case "ft":
                outputUnitLength = UnitLength.feet
            case "yd":
                outputUnitLength = UnitLength.yards
            case "mi":
                outputUnitLength = UnitLength.miles
            default:
                outputUnitLength = UnitLength.kilometers
            }
        } else if from == "ft" {
            inputUnitLength = UnitLength.feet
            
            switch to {
            case "m":
                outputUnitLength = UnitLength.miles
            case "ft":
                outputUnitLength = UnitLength.feet
            case "yd":
                outputUnitLength = UnitLength.yards
            case "mi":
                outputUnitLength = UnitLength.miles
            default:
                outputUnitLength = UnitLength.kilometers
            }
        } else if from == "yd" {
            inputUnitLength = UnitLength.yards
            
            switch to {
            case "m":
                outputUnitLength = UnitLength.miles
            case "ft":
                outputUnitLength = UnitLength.feet
            case "yd":
                outputUnitLength = UnitLength.yards
            case "mi":
                outputUnitLength = UnitLength.miles
            default:
                outputUnitLength = UnitLength.kilometers
            }
        } else { // from == "m"
            switch to {
            case "m":
                outputUnitLength = UnitLength.miles
            case "ft":
                outputUnitLength = UnitLength.feet
            case "yd":
                outputUnitLength = UnitLength.yards
            case "mi":
                outputUnitLength = UnitLength.miles
            default:
                outputUnitLength = UnitLength.kilometers
            }
        }
        
        let inputLength = Measurement(value: userInput, unit: inputUnitLength)
        let outputLength = inputLength.converted(to: outputUnitLength)
        
        return outputLength.value.formatted()
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section("Input Length") {
                    TextField("Input", value: $userInput, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("", selection: $inputUnit) {
                        ForEach(unitLength, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section("Output Length") {
                    Text("\(output)")
                    
                    Picker("", selection: $outputUnit) {
                        ForEach(unitLength, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Length Convertor")
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
