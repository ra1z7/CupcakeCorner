//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 10/10/2025.
//

import SwiftUI

struct AddressView: View {
    // Previously we've seen how Xcode lets us bind to local @State properties just fine, even when those properties are classes using the @Observable macros. That works because the @State property wrapper automatically creates two-way bindings for us, which we access through the $ syntax – $name, $age, etc. We haven't used @State in AddressView because we aren't creating the class here, we're just receiving it from elsewhere. This means SwiftUI doesn't have access to the same two-way bindings we'd normally use, which is a problem. Now, we know this class uses the @Observable macro, which means SwiftUI is able to watch this data for changes. So, what the @Bindable property wrapper does is create the missing bindings for us – it produces two-way bindings that are able to work with the @Observable macro, without having to use @State to create local data.
    @Bindable var order: Order // Think of @Bindable as a special tool that says: "I know I don't own this order object, but it's an @Observable class, so I know it's designed to be watched. Please give me the ability to create two-way bindings ($) for its properties." It essentially "activates" the $ for an @Observable object that is passed into a view.
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name) // A TextField needs more than just data to display; it needs a binding, a live, two-way connection to the data source so it can read the value and write any changes back.
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check Out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
