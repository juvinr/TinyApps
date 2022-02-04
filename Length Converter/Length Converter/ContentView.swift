//
//  ContentView.swift
//  Length Converter
//
//  Created by Juvin R on 04/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input = 100.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    @FocusState private var inputIsFocused: Bool
    
    let units = ["Feet", "Kilometers", "Meters", "Miles", "Yards"]
    
    var result: String {
        let inputToMetersMultipler: Double
        let metersToOutputMultiplier: Double
        
        switch inputUnit {
            case "Feet":
                inputToMetersMultipler = 0.3048
            case "Kilometers":
                inputToMetersMultipler = 1000
            case "Miles":
                inputToMetersMultipler = 1609.34
            case "Yards":
                inputToMetersMultipler = 0.9144
            default:
                inputToMetersMultipler = 1.0
        }
        
        switch outputUnit {
            case "Feet":
                metersToOutputMultiplier = 3.28084
            case "Kilometers":
                metersToOutputMultiplier = 0.001
            case "Miles":
                metersToOutputMultiplier = 0.000621371
            case "Yards":
                metersToOutputMultiplier = 1.09361
            default:
                metersToOutputMultiplier = 1.0
        }
        
        let inputInMeters = input * inputToMetersMultipler
        let output = inputInMeters * metersToOutputMultiplier
        
        let outputString = output.formatted()
        return "\(outputString) \(outputUnit.lowercased())"
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                // Input Amount
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert")
                }
                
                // Choose input unit
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                
                // Choose output unit
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                
                // Result
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
    }
}
