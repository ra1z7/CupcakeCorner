//
//  ComplexHapticEffect.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 07/10/2025.
//

import CoreHaptics // a powerful framework you use when you want to design completely custom vibration patterns.
import SwiftUI

/*
 The Engine (CHHapticEngine) is the heart of Core Haptics. The engine is what generates and plays the vibrations on the device. You need to create an engine, start it before you play anything, and handle cases where it might stop (e.g., the app goes to the background).
 
 An Event (CHHapticEvent) is a single "haptic note." There are two main types:
 - Transient: A short, sharp tap or kick. It's instantaneous. Think of a single drum hit.
 - Continuous: A sustained vibration that lasts for a specific duration. Think of a buzzing or humming sound.
 
 Parameters (CHHapticParameter) are what you use to customize your events. They are the "adjectives" that describe the feeling. The two most important ones are:
 - Haptic Intensity: How strong is the vibration? (0.0 to 1.0)
 - Haptic Sharpness: What is the character of the vibration? A low sharpness value feels soft and dull (like a deep hum), while a high value feels crisp, sharp, and precise (like a hard tap). (0.0 to 1.0)
 
 A Pattern (CHHapticPattern) is the "sheet music." It's a collection of events and parameter changes arranged on a timeline. You design a pattern by placing different events at specific times to create a sequence. For example, a "heartbeat" pattern would be:
 - Tap (strong, sharp) at 0 seconds.
 - Tap (weaker, softer) at 0.1 seconds.
 - Pause...
 - Repeat.
 */

struct ComplexHapticEffect: View {
    @State private var hapticEngine: CHHapticEngine?
    
    var body: some View {
        Button("Play Complex Haptic", action: complexHaptic)
            .onAppear(perform: prepareHapticEngine)
    }
    
    func prepareHapticEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Failed to start haptic engine: \(error.localizedDescription)")
        }
    }
    
    func complexHaptic() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        /*
            // create one intense, sharp tap
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
         */
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let hapticIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let hapticSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let anEvent = CHHapticEvent(eventType: .hapticTransient, parameters: [hapticIntensity, hapticSharpness], relativeTime: i)
            events.append(anEvent)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let hapticIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let hapticSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let anEvent = CHHapticEvent(eventType: .hapticTransient, parameters: [hapticIntensity, hapticSharpness], relativeTime: 1 + i)
            events.append(anEvent)
        }
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ComplexHapticEffect()
}
