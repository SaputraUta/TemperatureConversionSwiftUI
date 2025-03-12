    //
    //  ContentView.swift
    //  TemperatureConversionSwiftUI
    //
    //  Created by Saputra on 12/03/25.
    //

    import SwiftUI

    struct ContentView: View {
        @State private var from = "Celcius"
        @State private var to = "Fahrenheit"
        @State private var value: Double = 0
        @FocusState private var isTemperatureFocused: Bool
        
        var convertedValue: Double {
            let originalValue = Double(value)
            if from == "Celcius" && to == "Fahrenheit" {
                return (originalValue * 9/5) + 32
            } else if from == "Fahrenheit" && to == "Celcius" {
                return ((originalValue - 32) * (5/9))
            } else if from == "Celcius" && to == "Kelvin" {
                return originalValue + 273.15
            } else if from == "Kelvin" && to == "Celcius" {
                return originalValue - 273.15
            } else if from == "Fahrenheit" && to == "Kelvin" {
                return ((originalValue + 459.67) * (5/9))
            } else if from == "Kelvin" && to == "Fahrenheit" {
                return ((originalValue * (9/5)) - 459.67)
            } else {
                return 0
            }
        }
        
        let units = ["Celcius", "Fahrenheit", "Kelvin"]
        var body: some View {
            NavigationStack {
                Form {
                    Section("Original Temperature") {
                        TextField("Temperature", value: $value, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isTemperatureFocused)
                    }
                    Section {
                        Picker("From", selection: $from){
                            ForEach(units, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Picker("To", selection: $to){
                            ForEach(units, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    Section("Converted Temperature") {
                        Text("\(convertedValue.formatted(.number)) \(to)")
                    }
                }
                    
                .pickerStyle(.menu)
                
                .navigationTitle("Temperature convertion")
                
                .toolbar {
                    if isTemperatureFocused {
                        Button("Done") {
                            isTemperatureFocused = false
                        }
                    }
                }
            }
        }
    }

    #Preview {
        ContentView()
    }
