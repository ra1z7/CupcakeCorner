//
//  DisableForm.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 04/10/2025.
//

import SwiftUI

struct DisableForm: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating Account...")
                }
                .disabled(disableForm)
            }
        }
    }
}

#Preview {
    DisableForm()
}
