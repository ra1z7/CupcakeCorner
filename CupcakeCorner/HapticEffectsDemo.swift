//
//  HapticEffectsDemo.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 06/10/2025.
//

import SwiftUI

struct HapticEffectsDemo: View {
    @State private var boolean = true
    
    let flexibilities: [String: SensoryFeedback.Flexibility] = [
        "Rigid": .rigid,
        "Soft": .soft,
        "Solid": .solid
    ]
    
    @State private var flexibility = "Soft"
    var impactFlexibility: SensoryFeedback.Flexibility {
        switch flexibility {
        case "Rigid":
            return .rigid
        case "Soft":
            return .soft
        default:
            return .solid
        }
    }
    
    @State private var intensity = 0.5
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Haptic Demo")
                .font(.title.bold())
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
            
            VStack {
                HStack(spacing: 20) {
                    VStack {
                        Text("Flexibility")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Picker("Flexibility", selection: $flexibility) {
                            ForEach(Array(flexibilities.keys), id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    VStack {
                        Text("Intensity")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Stepper("Intensity", value: $intensity, in: 0...1, step: 0.1)
                            .labelsHidden()
                    }
                }
                
                Button("Play \(flexibility) \(intensity.formatted())") { boolean.toggle() }
                    .sensoryFeedback(.impact(flexibility: impactFlexibility, intensity: intensity), trigger: boolean)
                    .buttonStyle(.bordered)
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    HapticEffectsDemo()
}
