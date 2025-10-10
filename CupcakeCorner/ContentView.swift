//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 01/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order() // only place where the order will be created – every other screen in our app will be passed with this property so they all work with the same data.
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select Type of Cupcake", selection: $order.type) {
                        ForEach(Order.allTypes.indices, id: \.self) { // This is a bad idea for mutable arrays because the order of your array can change at any time, but here our array order won’t ever change so it’s safe to use .indices.
                            Text(Order.allTypes[$0])
                        }
                    }
                    
                    Stepper("Number of Cupcakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
