//
//  ContentView.swift
//  Convert
//
//  Created by Juvin R on 20/01/22.
//

import SwiftUI

struct ContentView: View {
        
    @State private var temperature = 0.0
    @State private var selectedTempUnit = "Fahrenheit"
    @FocusState private var isInputNumberFocused: Bool
    
    let temperatureTypes = ["Fahrenheit", "Kelvin"]
    
    // Convert Temperature
    var convertedTemp: Double {
        let celsiusTemp = Measurement(value: temperature, unit: UnitTemperature.celsius)
        let fahrenheitTemp = celsiusTemp.converted(to: UnitTemperature.fahrenheit)
        let kelvinTemp = celsiusTemp.converted(to: UnitTemperature.kelvin)
        
        if selectedTempUnit == "Kelvin" {
            return kelvinTemp.value
        } else {
            return fahrenheitTemp.value
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                // Input Temperature
                Section {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputNumberFocused)
                } header: {
                    Text("Temperature (in Celsius)")
                }
                
                // Temperature Types
                Section {
                    Picker("Temperature", selection: $selectedTempUnit) {
                        ForEach(temperatureTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Output Temperature
                Section {
                    Text("\(convertedTemp.formatted())")
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Convert Temperature")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputNumberFocused = false
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
