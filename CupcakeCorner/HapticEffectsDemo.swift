//
//  HapticEffectsDemo.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 06/10/2025.
//

import SwiftUI

struct SimpleHapticDemo: View {
    @State private var tapCounter = 0
    var body: some View {
        Button("Tap Count: \(tapCounter)") {
            tapCounter += 1
        }
        .sensoryFeedback(.increase, trigger: tapCounter)
    }
}

struct HapticEffectsDemo: View {
    @State private var boolean = true
    
    let availableFlexibilities = ["Rigid", "Soft", "Solid"]
    @State private var selectedFlexibility = "Soft"
    
    var impactFlexibility: SensoryFeedback.Flexibility {
        switch selectedFlexibility {
        case "Rigid":
            return .rigid
        case "Solid":
            return .solid
        default:
            return .soft
        }
    }
    
    let availableWeights = ["Light", "Medium", "Heavy"]
    @State private var selectedWeight = "Medium"
    
    var impactWeight: SensoryFeedback.Weight {
        switch selectedFlexibility {
        case "Light":
            return .light
        case "Heavy":
            return .heavy
        default:
            return .medium
        }
    }
    
    @State private var flexibilityIntensity = 0.5
    @State private var weightIntensity = 0.5
    
    var body: some View {
        NavigationStack {
            VStack {
                /*
                 VStack {
                 Button("Alignment") { boolean.toggle() }
                 .sensoryFeedback(.alignment, trigger: boolean)
                 Button("Decrease") { boolean.toggle() }
                 .sensoryFeedback(.decrease, trigger: boolean)
                 Button("Error") { boolean.toggle() }
                 .sensoryFeedback(.error, trigger: boolean)
                 Button("Impact") { boolean.toggle() }
                 .sensoryFeedback(.impact, trigger: boolean)
                 Button("Increase") { boolean.toggle() }
                 .sensoryFeedback(.increase, trigger: boolean)
                 Button("Level Change") { boolean.toggle() }
                 .sensoryFeedback(.levelChange, trigger: boolean)
                 Button("Path Complete") { boolean.toggle() }
                 .sensoryFeedback(.pathComplete, trigger: boolean)
                 Button("Selection") { boolean.toggle() }
                 .sensoryFeedback(.selection, trigger: boolean)
                 Button("Start") { boolean.toggle() }
                 .sensoryFeedback(.start, trigger: boolean)
                 Button("Stop") { boolean.toggle() }
                 .sensoryFeedback(.stop, trigger: boolean)
                 Button("Success") { boolean.toggle() }
                 .sensoryFeedback(.success, trigger: boolean)
                 Button("Warning") { boolean.toggle() }
                 .sensoryFeedback(.warning, trigger: boolean)
                 }
                 */
                
                // Following approach, often called "data-driven views," makes your code shorter and much easier to modify than above:
                
                VStack {
                    let standardHaptics: [(name: String, feedback: SensoryFeedback)] = [
                        ("Alignment", .alignment),
                        ("Decrease", .decrease),
                        ("Error", .error),
                        ("Impact", .impact),
                        ("Increase", .increase),
                        ("Level Change", .levelChange),
                        ("Path Complete", .pathComplete),
                        ("Selection", .selection),
                        ("Start", .start),
                        ("Stop", .stop),
                        ("Success", .success),
                        ("Warning", .warning)
                    ]
                    
                    ForEach(standardHaptics, id: \.name) { haptic in
                        Button(haptic.name) { boolean.toggle() }
                            .sensoryFeedback(haptic.feedback, trigger: boolean)
                    }
                    
                    // You avoid writing the same button code 12 times.
                    // To add a new haptic, you only need to add one line to the standardHaptics array.
                }
                
                VStack {
                    HStack(spacing: 20) {
                        VStack {
                            Text("Flexibility")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Picker("Choose Flexibility", selection: $selectedFlexibility) {
                                ForEach(availableFlexibilities, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        VStack {
                            Text("Intensity")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Slider(value: $flexibilityIntensity, in: 0...1, step: 0.1) {
                                Text("Adjust Intensity")
                            } minimumValueLabel: {
                                Text("0")
                            } maximumValueLabel: {
                                Text("1")
                            }
                            .frame(width: 150)
                        }
                    }
                    
                    Button("Play \(selectedFlexibility) \(flexibilityIntensity.formatted())") { boolean.toggle() }
                        .sensoryFeedback(.impact(flexibility: impactFlexibility, intensity: flexibilityIntensity), trigger: boolean)
                        .buttonStyle(.bordered)
                        .padding()
                }
                .padding()
                
                VStack {
                    HStack(spacing: 20) {
                        VStack {
                            Text("Weight")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Picker("Choose Weight", selection: $selectedWeight) {
                                ForEach(availableWeights, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        VStack {
                            Text("Intensity")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Slider(value: $weightIntensity, in: 0...1, step: 0.1) {
                                Text("Adjust Intensity")
                            } minimumValueLabel: {
                                Text("0")
                            } maximumValueLabel: {
                                Text("1")
                            }
                            .frame(width: 150)
                        }
                    }
                    
                    Button("Play \(selectedWeight) \(weightIntensity.formatted())") { boolean.toggle() }
                        .sensoryFeedback(.impact(weight: impactWeight, intensity: weightIntensity), trigger: boolean)
                        .buttonStyle(.bordered)
                        .padding()
                }
                .padding()
            }
            .navigationTitle("Haptic Effects Demo")
        }
    }
}

#Preview {
    HapticEffectsDemo()
}
