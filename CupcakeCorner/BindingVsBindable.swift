//
//  BindingVsBindable.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 12/10/2025.
//

import SwiftUI

/*
 @Binding and @Bindable both create two-way connections to data, but they operate on different kinds of data sources.

 @Binding creates a connection to a single property that is owned by a parent view, typically from an @State variable.

 @Bindable creates connections for all properties of an entire object that conforms to the Observable protocol.
 */

// @Binding Example:

// The Parent View owns the state
struct LivingRoom: View {
    @State private var isLightOn = false // Source of truth

    var body: some View {
        VStack {
            Text(isLightOn ? "The light is ON" : "The light is OFF")
            // Pass a binding ($) to the single boolean
            LightSwitch(isOn: $isLightOn)
        }
    }
}

// The Child View receives the binding
struct LightSwitch: View {
    @Binding var isOn: Bool // Creates a connection to the parent's @State

    var body: some View {
        Toggle("Switch", isOn: $isOn) // Toggling this changes the parent's state
    }
}




// @Bindable Example:

// The shared data model
@Observable
class ExampleUser {
    var name = "Alex"
    var age = 30
}

// A parent view might own the user object
struct ProfileView: View {
    @State private var user = ExampleUser()

    var body: some View {
        // Pass the whole object to the editing view
        EditProfileView(user: user)
    }
}

// The editing view uses @Bindable to get bindings
struct EditProfileView: View {
    @Bindable var user: ExampleUser // Enables bindings for all properties of `user`

    var body: some View {
        Form {
            // Now you can use $ to bind to any property of the user object
            TextField("Name", text: $user.name)
            Stepper("Age: \(user.age)", value: $user.age, in: 1...99, step: 1)
        }
    }
}
