//
//  PracticeDiceRoller.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 15/10/2025.
//

import SwiftUI

struct PracticeDiceRoller: View {
    @State private var currentSide = 1
    @State private var rotationAmount = 0.0
    
    var body: some View {
        Spacer()
        
        HStack {
            Text("Dice")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.red)
            Text("Roller")
                .font(.system(size: 30, weight: .bold, design: .rounded))
        }
        
        Spacer()
        Spacer()
        
        Image(systemName: "die.face.\(currentSide)")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .foregroundStyle(.primary, .red)
            .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 0, z: Bool.random() ? -1 : 1))
            .onTapGesture(perform: rollDice)
        
        Spacer()
        Spacer()
        Spacer()
    }
    
    func rollDice() {
        withAnimation(.bouncy) {
            currentSide = Int.random(in: 1...6)
            rotationAmount += 360.0
        }
    }
}

#Preview {
    PracticeDiceRoller()
}
